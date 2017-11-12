require 'test_helper'

class SubCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get sub_categories_create_url
    assert_response :success
  end

  test "should get update" do
    get sub_categories_update_url
    assert_response :success
  end

  test "should get destroy" do
    get sub_categories_destroy_url
    assert_response :success
  end

end
