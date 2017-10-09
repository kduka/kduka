require 'test_helper'

class LayoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @layout = layouts(:one)
  end

  test "should get index" do
    get layouts_url
    assert_response :success
  end

  test "should get new" do
    get new_layout_url
    assert_response :success
  end

  test "should create layout" do
    assert_difference('Layout.count') do
      post layouts_url, params: { layout: { d_name: @layout.d_name, d_name: @layout.d_name, description: @layout.description, name: @layout.name, preview: @layout.preview } }
    end

    assert_redirected_to layout_url(Layout.last)
  end

  test "should show layout" do
    get layout_url(@layout)
    assert_response :success
  end

  test "should get edit" do
    get edit_layout_url(@layout)
    assert_response :success
  end

  test "should update layout" do
    patch layout_url(@layout), params: { layout: { d_name: @layout.d_name, d_name: @layout.d_name, description: @layout.description, name: @layout.name, preview: @layout.preview } }
    assert_redirected_to layout_url(@layout)
  end

  test "should destroy layout" do
    assert_difference('Layout.count', -1) do
      delete layout_url(@layout)
    end

    assert_redirected_to layouts_url
  end
end
