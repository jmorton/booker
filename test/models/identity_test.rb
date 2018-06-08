require 'test_helper'

class IdentityTest < ActiveSupport::TestCase

  test "creating an identity" do
    identity = build(:identity)
    identity.save
    assert identity.valid?
  end

  test "creating an identity using #authorize" do
    auth_hash = OmniAuth::AuthHash.new({
      provider: 'developer',
      uid: 'test'
    })
    identity = Identity.authenticate(auth_hash)
    assert identity.valid?
  end

end
