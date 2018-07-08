class Frontend::CommentsController < ApplicationController
  before_action :set_resource

  def index
    @page = params[:page]
  end

  def create
    comment = @resource.comments.create(comment_params)
    if comment.errors.blank?
      # saved
    else
      # not saved
    end
  end

  private

  def set_resource
    @resource = AbstractPost.friendly.find(params[:post_id])
  end

  def comment_params
    require(:comment).permit(
      :body
    )
  end


end
