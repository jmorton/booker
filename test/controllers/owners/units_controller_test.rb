require 'test_helper'

class Guests::UnitsControllerTest < ActionDispatch::IntegrationTest

  test "get owner's units as unauthenticated user" do
    get '/owner/reservations'
    assert_response :redirect
  end

  test "get owner's units as authenticated user" do
    as_user do
      get '/owner/units'
      assert_response :ok
    end
  end

end
