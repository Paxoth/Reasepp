require 'test_helper'

class PresentationControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get contacto" do
    get :contacto
    assert_response :success
  end

  test "should get somos" do
    get :somos
    assert_response :success
  end

  test "should get hacemos" do
    get :hacemos
    assert_response :success
  end

  test "should get aprendizaje" do
    get :aprendizaje
    assert_response :success
  end

end
