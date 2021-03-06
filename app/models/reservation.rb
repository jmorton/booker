# frozen_string_literal: true

# The Reservation model represents a time interval that a Unit is exclusively
# reserved for a Guest.
#
class Reservation < ApplicationRecord
  include Label

  belongs_to :guest,   required: true
  belongs_to :unit,    required: true

  validates :start_at, presence: true
  validates :end_at,   presence: true
  validate  :availability

  default_scope { order(:start_at) }

  scope :during, lambda { |starts, ends|
    query = 'daterange(reservations.start_at, reservations.end_at) && daterange(?, ?)'
    where(query, starts, ends)
  }

  scope :before, lambda {
    where('end_at < ?', Time.now)
  }

  scope :now, lambda {
    query = 'daterange(reservations.start_at, reservations.end_at) && daterange(?, ?)'
    where(query, Time.now, Time.now)
  }

  scope :soon, lambda {
    where('start_at > ? and start_at < ?', Time.now, 1.month.from_now)
  }

  scope :later, lambda {
    where('start_at > ?', 1.month.from_now)
  }

  def check_in_at
    Time.use_zone(unit.local_tz) do
      Chronic.parse("#{start_at} at #{unit.check_in}")
    end
  end

  def check_out_at
    Time.use_zone(unit.local_tz) do
      Chronic.parse("#{end_at} at #{unit.check_out}")
    end
  end

  # A relation for getting or counting conflicting reservations for the same unit.
  #
  def conflicts
    if new_record?
      query = 'unit_id = ? AND daterange(start_at, end_at) && daterange(?, ?)'
      Reservation.where(query, unit_id, start_at, end_at)
    else
      query = 'id <> ? AND unit_id = ? AND daterange(start_at, end_at) && daterange(?, ?)'
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
    errors.add(:base, 'unit not available between given dates')
  end
end
