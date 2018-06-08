Feature: Search for units

Background:
  Given there are 1 units without reservations
    And there are 2 units reserved "tomorrow"
    And there are 3 units reserved "next week"

Scenario: Searching for available units
   When I search for units near "Sioux Falls, SD" available "tomorrow"
   Then I see 4 available units
   When I search for units near "Sioux Falls, SD" available "next week"
   Then I see 3 available units
   When I search for units near "Sioux Falls, SD" available "next month"
   Then I see 6 available units

Scenario: Searching in a place where there are no units
   When I search for units near "Salt Lake, NV" available "tomorrow"
   Then I see 0 available units

Scenario: Searching backwards in time
   When I search for units near "Siox Falls, SD" available "last year"
   Then I see 0 available units
    And I see an error "start time and end time must both be in the future"
