require 'test_helper'

class IdentitiesControllerTest < ActionDispatch::IntegrationTest

  test "get home view as unauthenticated user" do
    get '/'
    assert_response :redirect
  end

  test "get home view as authenticated user" do
    as_user do
      get '/'
      assert_response :redirect
    end
  end

end
