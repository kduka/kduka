require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get user" do
    get home_user_url
    assert_response :success
  end

  test "should get store" do
    get home_store_url
    assert_response :success
  end

end
