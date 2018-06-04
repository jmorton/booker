# The Reservation model represents a time interval that a Unit is exclusively
# reserved for a Guest.
#

class Reservation < ApplicationRecord

  audited

  belongs_to :guest,   required: true
  belongs_to :unit,    required: true

  validates :start_at, presence: true
  validates :end_at,   presence: true
  validate  :availability

  # A relation for selecting reservations that overlap a timerange.
  #
  def self.during(t1, t2)
    self.where('tstzrange(reservations.start_at, reservations.end_at) && tstzrange(?, ?)', t1, t2)
  end

  # A relation for getting or counting conflicting reservations for the same unit.
  #
  def conflicts
    if self.new_record?
      Reservation.where("unit_id = ? AND tstzrange(start_at, end_at) && tstzrange(?, ?)", unit_id, start_at, end_at)
    else
      Reservation.where("id <> ? AND unit_id = ? AND tstzrange(start_at, end_at) && tstzrange(?, ?)", id, unit_id, start_at, end_at)
    end
  end

  private

  # Detect other reservations for the same unit for an overlapping time. This
  # excludes the current reservation to avoid a condition where validation is
  # run after its initial creation. This validation cannot prevent two separate
  # instances of the app from running at the same time; we rely on a database
  # constraint to enforce the exclusive reservation of a Unit.
  #
  def availability
    # We count other reservations for the same unit during a time interval,
    # but we ignore this reservation. If we didn't ignore this reservation,
    # the count would be either 0 (when creating) or a 1 (when updating).
    if self.conflicts.count > 0
      self.errors.add(:start_at, "unit not available for given dates")
      self.errors.add(:end_at, "unit not available for given dates")
    end
  end

end
