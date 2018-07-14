# frozen_string_literal: true

class Frontend::PostsController < FrontendController
  before_action :set_category

  def index
    @popular_posts = AbstractPost.includes(:category).where(category_id: @category.child_ids + [@category.id]).limit(5)
    @posts = if @category.root?
               AbstractPost.where(category_id: @category.child_ids + [@category.id])
             else
               @category.posts
             end
    @posts = @posts.active.includes(:category).page(params[:page]).order(:created_at)
    set_partial
  end

  def show
    @post = AbstractPost.friendly.find(params[:id])
  end

  private

  def set_partial
    return @partial = 'ads' if params[:category_id] == 'ads'
    @partial = 'posts'
    @partial = 'articles' if @posts.first&.type == 'Article'
    @partial = 'affiches' if @posts.first&.type == 'Affiche'
  end

  def set_category
    @category = Category.friendly.find(params[:category_id])
  end
end
