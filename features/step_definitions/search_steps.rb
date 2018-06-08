When("I search for units near {string} available {string}") do |location, date|
  step 'I go to "/search"'
  start_at = Chronic.parse(date)
  end_at = start_at + 1.day
  page.fill_in 'search[near]',     with: location
  page.fill_in 'search[start_at]', with: start_at.iso8601
  page.fill_in 'search[end_at]',   with: end_at.iso8601
  page.click_button 'Search'
end

When("I search for an available unit") do
  step 'I search for units near "Sioux Falls, SD" available "next week"'
end

When("I pick a unit") do
  within("#results li:nth-child(1)") do
    page.click_link 'reserve'
  end
end

Then("I see a search form") do
  expect(page).to have_field('search[near]')
  expect(page).to have_field('search[start_at]')
  expect(page).to have_field('search[end_at]')
end

Then("I see {int} units") do |amount|
  expect(page).to have_selector('#results li', count: amount)
end

Then("I see {int} available units") do |amount|
  expect(page).to have_selector('#results li', count: amount)
end
