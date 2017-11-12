require 'test_helper'

class IpnControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ipn_index_url
    assert_response :success
  end

end
