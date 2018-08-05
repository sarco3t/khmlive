# frozen_string_literal: true

class Frontend::PostsController < FrontendController
  before_action :authenticate_user!, only: %i[like dislike]
  before_action :set_category
  before_action :set_post, only: %i[show like dislike]
  respond_to :js, :html, :json

  def index
    @posts = if @category.root?
               AbstractPost.where(category_id: @category.child_ids + [@category.id])
             else
               @category.posts
             end
    @posts = @posts.active.page(params[:page]).order(:created_at)
    @posts.each { |post| mark_as_viewed(post) }
    method = request.path.split('/').second.to_sym
    respond_with do |format|
      format.html do
        if respond_to?(method)
          public_send(method)
        else
          @popular_posts = AbstractPost
            .active.includes(:category).where(category_id: @category.child_ids + [@category.id]).limit(5) if request.format.html?
        end
        set_partial
      end
      format.json {  }
    end
  end

  def create
    @category.posts.create(post_params)
    redirect_back(fallback_location: root_path)
  end

  def show

  end

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
    params.require(:post).permit(:body, :type)
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
    @category = Category.friendly.find(params[:category_id])
  end
end
