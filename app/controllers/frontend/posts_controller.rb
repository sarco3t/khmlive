# frozen_string_literal: true

class Frontend::PostsController < FrontendController
  before_action :set_category

  def index
    @posts = if @category.root?
               AbstractPost.where(category_id: @category.child_ids)
             else
               @category.posts
             end
    @posts = @posts.page(params[:page])
  end

  private

  def set_category
    @partial = 'posts'
    @partial = 'articles' if params[:category_id] == 'news'
    @category = Category.friendly.find(params[:category_id])
  end
end
