# frozen_string_literal: true

class Frontend::UsersController < FrontendController
  def show
    @user = User.friendly.find(params[:id])
  end
end
