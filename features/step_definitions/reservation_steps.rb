Given("there is/are {int} unit(s)") do |n|
  n.times { create(:unit) }
end

When("someone reserves a unit") do
  unit = Unit.first
  create(:reservation, unit: unit)
end

When("I search for available units") do
  t1 = 1.day.from_now
  t2 = 1.week.from_now
  @units = Unit.available(t1, t2).all
end

Then("I get {int} unit(s)") do |n|
  assert_equal n, @units.length
end
