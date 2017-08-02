require 'test_helper'

class FilesControllerTest < ActionController::TestCase
  test "should get upload_files" do
    get :upload_files
    assert_response :success
  end

  test "should get list_files" do
    get :list_files
    assert_response :success
  end

  test "should get delete_files" do
    get :delete_files
    assert_response :success
  end

end
