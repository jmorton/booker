puts "Loading identity steps..."

Given("I am signed into Booker") do
  page.visit '/login'
  page.click_link 'Developer'
end

Given("I am not signed into Booker") do
  page.visit '/logout'
end

When("I sign in") do
  page.click_link 'Developer'
end

When("I sign out") do
  step "I am not signed into Booker"
end

Then("I have to login") do
  expect(page).to have_content('Please sign in to continue.')
end
