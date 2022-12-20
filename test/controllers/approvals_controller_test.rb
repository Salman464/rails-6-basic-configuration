require 'test_helper'

class ApprovalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get approvals_index_url
    assert_response :success
  end

  test "should get show" do
    get approvals_show_url
    assert_response :success
  end

end
