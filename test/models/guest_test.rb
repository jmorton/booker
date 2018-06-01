require 'test_helper'

class GuestTest < ActiveSupport::TestCase

  test "create user" do
    g = create(:guest)
    assert g.valid?, "could not create a Guest (using the factory)"
  end

end
