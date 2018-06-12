# frozen_string_literal: true

# The Search model provides us with criteria handling and query building. Without
# it, the Unit model or controller becomes cluttered with parameter wrangling
# that relates, but is quite different from, units themselves.
#
class Search
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Callbacks

  attribute :near,     :string
  attribute :start_at, :datetime
  attribute :end_at,   :datetime

  validates :near,     presence: true
  validates :start_at, presence: true
  validates :end_at,   presence: true

  validate  :subsequence
  validate  :duration

  define_model_callbacks :validation

  def start_at=(value)
    super Chronic.parse value
  end

  def end_at=(value)
    super Chronic.parse value
  end

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
    return if start_at.blank? || end_at.blank?
    return if (Time.now <= start_at) && (Time.now <= end_at)
    errors.add(:base, 'start time and end time must both be in the future')
  end

  # Ensure the difference between the times is a certain amount.
  #
  def duration
    # REVIEW: buried configuration? (1 day)
    return if start_at.blank? || end_at.blank?
    return if (end_at - start_at) >= 1.day
    errors.add(:base, 'start and end difference must be one or more days')
  end
end
