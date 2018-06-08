# frozen_string_literal: true

# The Identity model keeps information returned by an authentication provider.
#
# This model does not inherit from ApplicationRecord because it should not be
# audited.
#
# An Identity is associated with a guest (and eventually) an owner. This gives
# us a way to forget about individual people without having to delete data that
# we depend upon for referential integrity. For example, if a person deletes
# their identity, we still have a reference to a Guest.
#
# Use Identity for personally identifying information.
#
class Identity < ActiveRecord::Base
  has_one :guest

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  # Find or create an Identity from the given OmniAuth::AuthHash.
  #
  def self.authenticate(auth_hash)
    query = { provider: auth_hash.provider, uid: auth_hash.uid }
    Identity.where(query).first_or_create do |i|
      i.provider = auth_hash.provider
      i.uid      = auth_hash.uid
      i.info     = auth_hash.info
      i.extra    = auth_hash.extra
      i.save!
    end
  end
end
