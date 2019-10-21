require 'test_helper'

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  test "should get generate" do
    get invoices_generate_url
    assert_response :success
  end

end
