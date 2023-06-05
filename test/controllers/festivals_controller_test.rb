require "test_helper"

class FestivalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get festivals_index_url
    assert_response :success
  end

  test "should get new" do
    get festivals_new_url
    assert_response :success
  end

  test "should get create" do
    get festivals_create_url
    assert_response :success
  end

  test "should get destroy" do
    get festivals_destroy_url
    assert_response :success
  end

  test "should get show" do
    get festivals_show_url
    assert_response :success
  end

  test "should get update" do
    get festivals_update_url
    assert_response :success
  end
end
