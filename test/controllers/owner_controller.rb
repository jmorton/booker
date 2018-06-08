require 'test_helper'

class Guests::ReservationsControllerTest < ActionDispatch::IntegrationTest

  test "get owner view as unauthenticated user" do
    get '/owner'
    assert_response :redirect
  end

  test "get owner view as authenticated user" do
    as_user do
      get '/owner'
      assert_response :ok
    end
  end

end
