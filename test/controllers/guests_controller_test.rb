require 'test_helper'

class Guests::ReservationsControllerTest < ActionDispatch::IntegrationTest

  test "get guest view as unauthenticated user" do
    get '/guest'
    assert_response :redirect
  end

  test "get guest view as authenticated user" do
    as_user do
      get '/guest'
      assert_response :ok
    end
  end

end
