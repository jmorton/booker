Feature: Manage units

  As an Owner I can manage units
  So that Guests can reserve them

  Background:
    Given I am signed into Booker

  Scenario: View my list of units before creating any
    When I go to "/owner"
     And I click "Manage Your Units"
    Then I see "You've not created any units, yet."

  Scenario: Creating a unit without enough information
    When I go to "/owner"
     And I click "Manage Your Units"
     And I click "New Unit"
     And I click "Create Unit"
    Then I see an error "Address can't be blank"

  Scenario: Creating a unit in Sioux Falls, SD
    When I go to "/owner"
     And I click "Manage Your Units"
     And I click "New Unit"
     And I enter this form:
         | address | Sioux Falls, SD |
     And I click "Create Unit"
    Then I see a message "Unit created"
    When I go to "/owner"
     And I click "Manage Your Units"
    Then I see exactly 1 "units"
