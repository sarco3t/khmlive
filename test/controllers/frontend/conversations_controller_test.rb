require 'test_helper'

class Frontend::ConversationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get frontend_conversations_index_url
    assert_response :success
  end

  test "should get create" do
    get frontend_conversations_create_url
    assert_response :success
  end

end
