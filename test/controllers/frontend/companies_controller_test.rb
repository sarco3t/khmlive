require 'test_helper'

class Frontend::CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get frontend_companies_index_url
    assert_response :success
  end

end
