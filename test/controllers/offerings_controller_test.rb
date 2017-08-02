require 'test_helper'

class OfferingsControllerTest < ActionController::TestCase
  setup do
    @offering = offerings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offerings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offering" do
    assert_difference('Offering.count') do
      post :create, offering: { area_id: @offering.area_id, community_id: @offering.community_id, description: @offering.description, end_time: @offering.end_time, experience_id: @offering.experience_id, start_time: @offering.start_time, status: @offering.status, title: @offering.title, user_id: @offering.user_id }
    end

    assert_redirected_to offering_path(assigns(:offering))
  end

  test "should show offering" do
    get :show, id: @offering
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offering
    assert_response :success
  end

  test "should update offering" do
    patch :update, id: @offering, offering: { area_id: @offering.area_id, community_id: @offering.community_id, description: @offering.description, end_time: @offering.end_time, experience_id: @offering.experience_id, start_time: @offering.start_time, status: @offering.status, title: @offering.title, user_id: @offering.user_id }
    assert_redirected_to offering_path(assigns(:offering))
  end

  test "should destroy offering" do
    assert_difference('Offering.count', -1) do
      delete :destroy, id: @offering
    end

    assert_redirected_to offerings_path
  end
end
