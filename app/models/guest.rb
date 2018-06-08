# frozen_string_literal: true

# The Guest model contains non-sensitive information about a user. It is
# a surrogate of sorts for an identity.
#
class Guest < ApplicationRecord
  belongs_to :identity, required: false
  has_many :reservations
  has_many :units, through: :reservations
end
