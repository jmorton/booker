Feature: Search for units

  As a Visitor I can search for units
  So that I can start the reservation process

  Scenario: Accessing Booker
    Given I am not signed into Booker
    When I go to '/'
    Then I see a search form
