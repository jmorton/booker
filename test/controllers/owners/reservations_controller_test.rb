require 'test_helper'

class Owners::ReservationsControllerTest < ActionDispatch::IntegrationTest

  test "get owner view as unauthenticated user" do
    get '/owner'
    assert_response :redirect
  end

  test "get owner reservations as unauthenticated user" do
    get '/owner/reservations'
    assert_response :redirect
  end

  test "get owner reservations as authenticated user" do
    as_user do
      get '/owner/reservations'
      assert_response :ok
    end
  end

end
