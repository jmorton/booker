Feature: Managing reservations

In order to avoid scheduling conflicts, a guest creates a reservation for a unit.

Scenario: Reserving an available unit
  Given unit "XYZ" has no reservations
  When I reserve unit "XYZ" for 2018-07-01/2018-07-03
  Then I'm told the reservation was created.

Scenario: Reserving an unavailable unit
  Given unit "XYZ" is already booked for 2018-07-01/2018-07-03
  When I reserve unit "XYZ"
  Then I'm told the reservation was not created.

Scenario: Reserving a non-existent unit
  When I reserve "UNIT-XYZ" for 2018-07-01/2018-07-03
  Then I'm told the reservation was not created.

Scenario: Cancelling a reservation
  Given unit "XYZ" is reserved for 2018-07-01/2018-07-03
  When I cancel the reservation
  Then I'm told the reservation was not cancelled
  And the unit is available from 2018-07-01/2018-07-03.

Scenario: Updating a reservation
  Given unit "XYZ" is reserved for 2018-07-01/2018-07-03
  When I change the reservation to 2018-07-02/2018-07-04
  Then I'm told the reservation was updated
   And the unit is available on 2018-07-01
   And the unit is available on 2018-07-05
