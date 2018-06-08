puts "Loading guest steps..."

Given("I reserved {int} units") do |amount|
  step 'I am signed into Booker'
  step 'I reserve an available unit'
  step 'I reserve another available unit'
end

When("I create a/the reservation") do
  page.click_button 'Create Reservation'
end

When("I reserve an/another available unit") do
  step 'I search for an available unit'
  step 'I pick a unit'
  step 'I create a reservation'
end

When("I follow the link to reservation details") do
  within('#reservations li:first') do
    page.click_link 'View'
  end
end

When("I follow the link to update a reservation") do
  within('#reservations li:first') do
    page.click_link 'Edit'
  end
end

When("I extend my reservation by {int} day(s)") do |amount|
  original = Chronic.parse(page.find_field('reservation[end_at]').value)
  updated  = original + amount.day
  page.fill_in 'reservation[end_at]', with: updated
end

When("I update the reservation") do
  page.click_button 'Update Reservation'
end

When("I follow the link to cancel a reservation") do
  within('#reservations li:first') do
    page.click_link 'Cancel'
  end
end

Then("I see details about the reservation") do
  within('.reservation') do
    expect(page).to have_selector('[data-attr=address]')
    expect(page).to have_selector('[data-attr=start_at]')
    expect(page).to have_selector('[data-attr=end_at]')
  end
end
