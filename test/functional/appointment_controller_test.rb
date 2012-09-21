require 'test_helper'

class AppointmentControllerTest < ActionController::TestCase
  test "should get request" do
    get :request
    assert_response :success
  end

end
