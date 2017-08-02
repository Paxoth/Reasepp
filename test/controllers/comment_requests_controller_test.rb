require 'test_helper'

class CommentRequestsControllerTest < ActionController::TestCase
  setup do
    @comment_request = comment_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comment_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comment_request" do
    assert_difference('CommentRequest.count') do
      post :create, comment_request: { body: @comment_request.body, request_id: @comment_request.request_id, user_id: @comment_request.user_id }
    end

    assert_redirected_to comment_request_path(assigns(:comment_request))
  end

  test "should show comment_request" do
    get :show, id: @comment_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comment_request
    assert_response :success
  end

  test "should update comment_request" do
    patch :update, id: @comment_request, comment_request: { body: @comment_request.body, request_id: @comment_request.request_id, user_id: @comment_request.user_id }
    assert_redirected_to comment_request_path(assigns(:comment_request))
  end

  test "should destroy comment_request" do
    assert_difference('CommentRequest.count', -1) do
      delete :destroy, id: @comment_request
    end

    assert_redirected_to comment_requests_path
  end
end
