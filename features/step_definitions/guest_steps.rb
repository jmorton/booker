puts "Loading guest steps..."

Given("I reserved {int} units") do |amount|
  step 'I am signed into Booker'
  step 'I reserve an available unit'
  step 'I reserve another available unit'
end

When("I reserve an/another available unit") do
  step 'I search for an available unit'
  step 'I pick a unit'
  step 'I create the reservation'
end

When("I follow the link to reservation details") do
  # REVIEW: Pretty brittle selector...
  find('#reservations div:nth(1) a:nth(1)').click
end

When("I extend my reservation by {int} day(s)") do |amount|
  original = Chronic.parse(page.find_field('reservation[end_at]').value)
  updated  = original + amount.day
  page.fill_in 'reservation[end_at]', with: updated
end

When("I create the reservation") do
  page.click_button 'Create Reservation'
end

When("I update the reservation") do
  page.click_button 'Update Reservation'
end

When("I click the edit link") do
  page.click_link 'Edit'
end

When("I click the cancel link") do
  page.click_link 'Cancel'
end

Then("I see details about the reservation") do
  within('.reservation') do
    expect(page).to have_selector('[data-attr=address]')
    expect(page).to have_selector('[data-attr=start_at]')
    expect(page).to have_selector('[data-attr=end_at]')
  end
end
