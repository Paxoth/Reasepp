require 'test_helper'

class CommentOfferingsControllerTest < ActionController::TestCase
  setup do
    @comment_offering = comment_offerings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comment_offerings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comment_offering" do
    assert_difference('CommentOffering.count') do
      post :create, comment_offering: { body: @comment_offering.body, offering: @comment_offering.offering, user: @comment_offering.user }
    end

    assert_redirected_to comment_offering_path(assigns(:comment_offering))
  end

  test "should show comment_offering" do
    get :show, id: @comment_offering
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comment_offering
    assert_response :success
  end

  test "should update comment_offering" do
    patch :update, id: @comment_offering, comment_offering: { body: @comment_offering.body, offering: @comment_offering.offering, user: @comment_offering.user }
    assert_redirected_to comment_offering_path(assigns(:comment_offering))
  end

  test "should destroy comment_offering" do
    assert_difference('CommentOffering.count', -1) do
      delete :destroy, id: @comment_offering
    end

    assert_redirected_to comment_offerings_path
  end
end
