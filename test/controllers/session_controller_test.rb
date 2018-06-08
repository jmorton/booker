require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "redirect back to owners when originally requested" do
    get owners_path
    assert_redirected_to login_path
    get '/auth/developer' and follow_redirect!
    assert_redirected_to owners_path
  end

  test "redirect back to guests when originally requested" do
    get guests_path
    assert_redirected_to login_path
    get '/auth/developer' and follow_redirect!
    assert_redirected_to guests_path
  end
end
