require 'test_helper'

class Guests::UnitsControllerTest < ActionDispatch::IntegrationTest

  test "get guest's units as unauthenticated user" do
    get '/guest/units'
    assert_response :redirect
  end

  test "get guest's units as authenticated user" do
    as_user do
      get '/guest/units'
      assert_response :ok
    end
  end

end
