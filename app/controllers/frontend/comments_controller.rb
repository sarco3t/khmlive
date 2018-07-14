class Frontend::CommentsController < ApplicationController
  before_action :set_resource

  def index
    @comments = @resource.comments.page(params[:page])
  end

  def create
    @comment = @resource.comments.create(comment_params.merge(user_id: User.first.id))
  end

  private

  def set_resource
    @resource = AbstractPost.friendly.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(
      :body
    )
  end


end
