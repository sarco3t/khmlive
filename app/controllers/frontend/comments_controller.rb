class Frontend::CommentsController < ApplicationController
  before_action :set_resource, only: %i[index create]
  before_action :set_comment, only: %i[like dislike]
  before_action :authenticate_user!, only: %i[like dislike create]

  def index
    @comments = @resource.comments.page(params[:page])
  end

  def create
    @comment = @resource.comments.create(comment_params.merge(user_id: User.first.id))
  end

  def like
    @comment.likes.first_or_create(user: current_user)
  end

  def dislike
    @comment.likes.where(user: current_user).delete_all
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end


  def set_resource
    @resource = AbstractPost.friendly.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(
      :body
    )
  end


end
