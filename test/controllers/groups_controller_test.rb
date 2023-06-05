require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get groups_create_url
    assert_response :success
  end

  test "should get destroy" do
    get groups_destroy_url
    assert_response :success
  end

  test "should get update" do
    get groups_update_url
    assert_response :success
  end
end
