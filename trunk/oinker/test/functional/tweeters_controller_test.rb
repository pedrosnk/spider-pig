require 'test_helper'

class TweetersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tweeters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tweeter" do
    assert_difference('Tweeter.count') do
      post :create, :tweeter => { }
    end

    assert_redirected_to tweeter_path(assigns(:tweeter))
  end

  test "should show tweeter" do
    get :show, :id => tweeters(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tweeters(:one).to_param
    assert_response :success
  end

  test "should update tweeter" do
    put :update, :id => tweeters(:one).to_param, :tweeter => { }
    assert_redirected_to tweeter_path(assigns(:tweeter))
  end

  test "should destroy tweeter" do
    assert_difference('Tweeter.count', -1) do
      delete :destroy, :id => tweeters(:one).to_param
    end

    assert_redirected_to tweeters_path
  end
end
