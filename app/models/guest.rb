# frozen_string_literal: true

# The Guest model keeps information about a person that wants to reserve
# a unit for.
#
class Guest < ApplicationRecord
  has_many :reservations
end
