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
    @posts = @posts.includes(:category).page(params[:page])
  end

  private

  def set_category
    @partial = 'posts'
    @partial = 'articles' if params[:category_id] == 'news'
    @category = Category.friendly.find(params[:category_id])
  end
end
