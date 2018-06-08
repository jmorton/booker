require 'test_helper'

class GuestTest < ActiveSupport::TestCase

  test "create guest" do
    guest = create(:guest)
    assert guest.valid?, "could not create a Guest (using the factory)"
  end

end
