require 'test_helper'

class OwnerTest < ActiveSupport::TestCase

  test "create owner" do
    owner = create(:owner)
    assert owner.valid?, "could not create an Owner (using the factory)"
  end

end
