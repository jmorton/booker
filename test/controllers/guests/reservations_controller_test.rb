require 'test_helper'

class Guests::ReservationsControllerTest < ActionDispatch::IntegrationTest

  test "get guest reservations as unauthenticated user" do
    get '/guest/units'
    assert_response :redirect
  end

  test "get guest reservations as authenticated user" do
    as_user do
      get '/guest/units'
      assert_response :ok
    end
  end

end
