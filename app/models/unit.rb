# The Unit model represents a place that can be reserved by a Guest.
#
# It contains additional information to help users find a place to stay that
# meets their criteria.
#

class Unit < ApplicationRecord

  audited

  has_many :reservations

  # Address is absolutely required and should be unique. Duplicate addresses
  # could lead to duplicate booking!
  validates :address, presence: true, uniqueness: true

  # Minimize geocoder hits
  after_validation :geocode, if: ->(u) { u.address.present? and u.address_changed? }

  # Address contains everything needed to get a lat/lon.
  geocoded_by :address

  # A relation that selects units with reservations between times t1 and t2.
  #
  def self.reserved(t1, t2)
    where(id: Reservation.during(t1,t2))
  end


  # A relation that selects units without any reservations between times t1 and t2.
  #
  def self.available(t1, t2)
    where.not(id: Reservation.during(t1,t2))
  end


end
