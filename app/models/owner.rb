# frozen_string_literal: true

# The Owner model contains non-sensitive information about a user. It is
# a surrogate of sorts for an identity.
#
class Owner < ApplicationRecord
  belongs_to :identity, required: false
  has_many :units
  has_many :reservations, through: :units
end
