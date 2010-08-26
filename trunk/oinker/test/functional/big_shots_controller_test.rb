require 'test_helper'

class BigShotsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:big_shots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create big_shot" do
    assert_difference('BigShot.count') do
      post :create, :big_shot => { }
    end

    assert_redirected_to big_shot_path(assigns(:big_shot))
  end

  test "should show big_shot" do
    get :show, :id => big_shots(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => big_shots(:one).to_param
    assert_response :success
  end

  test "should update big_shot" do
    put :update, :id => big_shots(:one).to_param, :big_shot => { }
    assert_redirected_to big_shot_path(assigns(:big_shot))
  end

  test "should destroy big_shot" do
    assert_difference('BigShot.count', -1) do
      delete :destroy, :id => big_shots(:one).to_param
    end

    assert_redirected_to big_shots_path
  end
end
