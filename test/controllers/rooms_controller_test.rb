require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get rooms_create_url
    assert_response :success
  end

  test "should get destroy" do
    get rooms_destroy_url
    assert_response :success
  end

  test "should get update" do
    get rooms_update_url
    assert_response :success
  end
end
