require "test_helper"

class CellarsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get cellars_show_url
    assert_response :success
  end

  test "should get edit" do
    get cellars_edit_url
    assert_response :success
  end

  test "should get update" do
    get cellars_update_url
    assert_response :success
  end
end
