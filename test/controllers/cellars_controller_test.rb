require "test_helper"

class StocksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get stock_show_url
    assert_response :success
  end

  test "should get edit" do
    get stock_edit_url
    assert_response :success
  end

  test "should get update" do
    get stock_update_url
    assert_response :success
  end
end
