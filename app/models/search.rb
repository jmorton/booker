# frozen_string_literal: true

# The Search model provides us with criteria handling and query building. Without
# it, the Unit model or controller becomes cluttered with parameter wrangling
# that relates, but is quite different from, units themselves.
#
class Search
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :near, :string
  attribute :start_at, :datetime, default: -> { 1.week.from_now }
  attribute :end_at, :datetime, default: -> { 2.weeks.from_now }

  validates :near, presence: true
  validate  :subsequence
  validate  :duration

  # Prepare to search Units with given criteria without executing the search
  # so that additional constraints (e.g. pagination) may be applied.
  #
  def results
    Unit.near(near).available(start_at, end_at) if valid?
  end

  private

  # Ensure the given times are in the future.
  #
  def subsequence
    return if (Time.now <= start_at) && (Time.now <= end_at)
    errors.add(:base, 'start time and end time must both be in the future')
  end

  # Ensure the difference between the times is a certain amount.
  #
  def duration
    # REVIEW: buried configuration? (1 day)
    return if (end_at - start_at) >= 1.day
    errors.add(:base, 'start and end difference must be one or more days')
  end
end
