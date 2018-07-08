require 'test_helper'

class Frontend::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get frontend_comments_index_url
    assert_response :success
  end

  test "should get create" do
    get frontend_comments_create_url
    assert_response :success
  end

end
