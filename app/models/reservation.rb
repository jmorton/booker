# Reservations are used to prevent the same unit from being booked simultaneously
# by different guests. This constraint is enforced at the persistence layer to
# avoid race conditions that this application can't prevent. However, a custom
# validator is still used to detect this and report a helpful error.
#

class Reservation < ApplicationRecord

  audited

  belongs_to :guest,   required: true
  belongs_to :unit,    required: true

  validates :start_at, presence: true
  validates :end_at,   presence: true

  validate  :availability

  def self.during(t1, t2)
    self.where('tstzrange(reservations.start_at, reservations.end_at) && tstzrange(?, ?)', t1, t2)
  end


  private

  # Detect other reservations for the same unit for an overlapping time. This
  # excludes the current reservation to avoid a condition where validation is
  # run after the initial creation; otherwise, the record would appear to be
  # invalid!
  #
  def availability
    if Reservation.where("id <> ? AND unit_id = ? AND tstzrange(start_at, end_at) && tstzrange(?, ?)", id, unit_id, start_at, end_at).count > 0
      self.errors.add(:during, "unit not available for this time interval")
    end
  end

end
