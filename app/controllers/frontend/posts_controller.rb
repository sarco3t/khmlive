# frozen_string_literal: true

class Frontend::PostsController < FrontendController
  before_action :authenticate_user!, only: %i[like dislike create]
  before_action :set_category, except: [:search]
  before_action :set_post, only: %i[show like dislike]
  respond_to :js, :html, :json

  def search
    @posts = AbstractPost.search(params[:q]).page(params[:page] || 1).order(created_at: :desc)
  end

  def index
    @posts = if @category.nil?
              AbstractPost
            elsif @category.root?
               AbstractPost.where(category_id: @category.child_ids + [@category.id])
             else
               @category.posts
             end
    @posts = @posts.popular if params[:popular]
    @posts = @posts.active.page(params[:page]).order(created_at: :desc)
    @posts.each { |post| mark_as_viewed(post) }
    method = request.path.split('/').second.to_sym
    respond_with do |format|
      format.html do
        if respond_to?(method)
          public_send(method)
        end
        @popular_posts = AbstractPost
          .active
          .popular
          .includes(:category)
          .where(category_id: @category.child_ids + [@category.id])\
          .limit(5)
        set_partial
      end
      format.json {}
    end
  end

  def create
    @category.posts.create(post_params.merge(enabled: false))
    redirect_back(fallback_location: root_path)
  end

  def show; end

  def like
    @post.likes.first_or_create(user: current_user)
  end

  def dislike
    @post.likes.where(user: current_user).destroy_all
  end

  def directory
    @top_companies = Company
                     .group(:id)
                     .includes(:logo_attachment)
                     .order('avg(comments_count + likes_count + views_count) desc')
                     .limit(3)
    render 'frontend/categories/directory'
  end

  private

  def post_params
    params.require(:post).permit(:body, :type, :images)
  end

  def set_partial
    return @partial = 'ads' if params[:category_id] == 'ads'
    @partial = 'posts'
    @partial = 'articles' if @posts.first&.type == 'Article'
    @partial = 'affiches' if @posts.first&.type == 'Affiche'
  end

  def set_post
    @post = AbstractPost.friendly.find(params[:id])
  end

  def set_category
    @category = if params[:category_id] == 'all'
                  nil
                else
                  Category.friendly.find(params[:category_id])
                end
  end
end
