require 'test_helper'

class InterestLinksControllerTest < ActionController::TestCase
  setup do
    @interest_link = interest_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:interest_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create interest_link" do
    assert_difference('InterestLink.count') do
      post :create, interest_link: { description: @interest_link.description, name: @interest_link.name, url: @interest_link.url }
    end

    assert_redirected_to interest_link_path(assigns(:interest_link))
  end

  test "should show interest_link" do
    get :show, id: @interest_link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @interest_link
    assert_response :success
  end

  test "should update interest_link" do
    patch :update, id: @interest_link, interest_link: { description: @interest_link.description, name: @interest_link.name, url: @interest_link.url }
    assert_redirected_to interest_link_path(assigns(:interest_link))
  end

  test "should destroy interest_link" do
    assert_difference('InterestLink.count', -1) do
      delete :destroy, id: @interest_link
    end

    assert_redirected_to interest_links_path
  end
end
