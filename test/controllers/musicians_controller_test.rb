require "test_helper"

class MusiciansControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get musicians_create_url
    assert_response :success
  end

  test "should get destroy" do
    get musicians_destroy_url
    assert_response :success
  end

  test "should get update" do
    get musicians_update_url
    assert_response :success
  end
end
