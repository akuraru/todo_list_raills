require 'test_helper'

class MessageControllerTest < ActionController::TestCase
  test "should get show" do
  	session[:user_id] = 1
    get :all 
    assert_response :success
  end

end
