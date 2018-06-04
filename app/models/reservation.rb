# frozen_string_literal: true

# The Reservation model represents a time interval that a Unit is exclusively
# reserved for a Guest.
#
class Reservation < ApplicationRecord
  belongs_to :guest,   required: true
  belongs_to :unit,    required: true

  validates :start_at, presence: true
  validates :end_at,   presence: true
  validate  :availability

  # A relation for selecting reservations that overlap a timerange.
  #
  def self.during(starts, ends)
    query = 'tstzrange(reservations.start_at, reservations.end_at) && tstzrange(?, ?)'
    where(query, starts, ends)
  end

  # A relation for getting or counting conflicting reservations for the same unit.
  #
  def conflicts
    if new_record?
      query = 'unit_id = ? AND tstzrange(start_at, end_at) && tstzrange(?, ?)'
      Reservation.where(query, unit_id, start_at, end_at)
    else
      query = 'id <> ? AND unit_id = ? AND tstzrange(start_at, end_at) && tstzrange(?, ?)'
      Reservation.where(query, id, unit_id, start_at, end_at)
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
    return unless conflicts.count.positive?
    errors.add(:start_at, 'unit not available for given dates')
  end
end
