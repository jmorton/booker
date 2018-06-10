require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "redirect back to owners when originally requested" do
    get owner_path
    assert_redirected_to login_path
    get '/auth/developer' and follow_redirect!
    assert_redirected_to owner_path
  end

  test "redirect back to guests when originally requested" do
    get guest_path
    assert_redirected_to login_path
    get '/auth/developer' and follow_redirect!
    assert_redirected_to guest_path
  end
end
