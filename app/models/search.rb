# The Search model provides us with criteria handling and query building. Without
# it, the Unit model or controller becomes cluttered with parameter wrangling
# that relates, but is quite different from, units themselves.
#

class Search
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :near, :string, default: "Sioux Falls, SD"
  attribute :start_at, :date, default: -> { 1.week.from_now }
  attribute :end_at, :date, default: -> { 2.weeks.from_now }

  # Prepare to search Units with given criteria without executing the search
  # so that additional constraints (e.g. pagination) may be applied.
  #
  def results
    Unit.near(near).available(start_at, end_at)
  end

end
