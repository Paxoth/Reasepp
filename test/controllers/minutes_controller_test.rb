require 'test_helper'

class MinutesControllerTest < ActionController::TestCase
  test "should get upload_minutes" do
    get :upload_minutes
    assert_response :success
  end

  test "should get list_minutes" do
    get :list_minutes
    assert_response :success
  end

  test "should get delete_minutes" do
    get :delete_minutes
    assert_response :success
  end

end
