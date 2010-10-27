require 'test_helper'

class StatusInfluenceControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
