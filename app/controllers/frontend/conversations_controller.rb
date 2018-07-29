class Frontend::ConversationsController < FrontendController
  before_action :authenticate_user!

  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.mark_as_read(current_user)
  end

  def create
    current_user.send_message User.find(params[:id]), params[:body], ''
  end
end
