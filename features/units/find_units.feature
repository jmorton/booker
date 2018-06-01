Feature: Search Units
  As a Guest I can find available Units near a Place
  So that I can Reserve something for a time interval

  Background:
    Given there are 3 units

  Scenario: Searching among unreserved units
    When I search for available units
    Then I get 3 units

  Scenario: Searching among reserved units
    When someone reserves a unit
    And I search for available units
    Then I get 2 units
