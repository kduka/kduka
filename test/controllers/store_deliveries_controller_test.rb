require 'test_helper'

class StoreDeliveriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get store_deliveries_create_url
    assert_response :success
  end

  test "should get new" do
    get store_deliveries_new_url
    assert_response :success
  end

end
