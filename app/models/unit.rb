# frozen_string_literal: true

# The Unit model represents a place that can be reserved by a Guest.
#
class Unit < ApplicationRecord
  belongs_to :owner
  has_many :reservations

  # Address is absolutely required and should be unique. Duplicate addresses
  # could lead to duplicate booking!
  #
  validates :address, presence: true, uniqueness: true

  # Minimize geocoder hits by only geocoding when possible and needed.
  #
  after_validation :geocode, if: ->(u) { u.address.present? && u.address_changed? }

  # Address contains everything needed to get a lat/lon; it has not been decomposed
  # into street, city, state, etc...
  #
  geocoded_by :address

  # A relation that selects units with reservations between times t1 and t2.
  #
  def self.reserved(starts, ends)
    where(id: Reservation.during(starts, ends).select(:unit_id))
  end

  # A relation that selects units without any reservations between times t1 and t2.
  #
  def self.available(starts, ends)
    where.not(id: Reservation.during(starts, ends).select(:unit_id))
  end
end
