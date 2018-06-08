puts "Loading shared steps..."

Given("there is/are {int} unit(s) without reservations") do |amount|
  amount.times { create(:unit) }
end

Given("there is/are {int} unit(s) reserved {string}") do |amount, date|
  start_at = Chronic.parse(date)
  end_at = start_at + 1.day
  create_list(:reservation, amount, start_at: start_at, end_at: end_at)
end

When("I go to {string}") do |path|
  visit path
end

Then("I see a/an/the error {string}") do |text|
  within('.errors') do
    expect(page).to have_content(text)
  end
end

Then("I see no errors") do
  expect(page).not_to have_select('.errors')
end

Then("I see a/an/the message {string}") do |text|
  within('.flash') do
    expect(page).to have_content(text)
  end
end

Then("I see no messages") do
  expect(page).not_to have_selector(".flash")
end

Then("I see exactly {int} {string}") do |quantity, thing|
  name = ActiveSupport::Inflector.singularize(thing)
  within('content') do
    expect(page).to have_selector("[data-type=#{name}]", count: quantity)
  end
end
