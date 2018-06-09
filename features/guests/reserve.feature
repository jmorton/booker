Feature: Reserve a unit

  As a Guest I can manage my own reservations
  So that I have somewhere to stay later.

  Background:
    Given there are 3 units without reservations

  Scenario: Reserving a unit as a signed in guest
    Given I am signed into Booker
     When I reserve an available unit
     Then I see details about the reservation
      And I see the message 'Reservation created.'

  Scenario: Reserving a unit without being signed in first
    Given I am not signed into Booker
     When I search for an available unit
      And I pick a unit
     Then I have to login
     When I sign in
      And I create the reservation
     Then I see details about the reservation

  Scenario: Viewing my list of reservations
    Given I reserved 2 units
     When I go to '/guest/reservations'
     Then I see exactly 2 'reservations'

  Scenario: Viewing details about a reservation
    Given I reserved 2 units
      And I go to '/guest/reservations'
      And I follow the link to reservation details
     Then I see details about the reservation

  Scenario: Cancelling a reservation
    Given I reserved 2 units
      And I go to '/guest/reservations'
      And I follow the link to reservation details
      And I click the cancel link
     Then I see exactly 1 'reservation'
      And I see the message 'Reservation cancelled.'

  Scenario: Updating a reservation
     Given I reserved 2 units
      When I go to '/guest/reservations'
       And I follow the link to reservation details
       And I click the edit link
       And I extend my reservation by 1 day
       And I update the reservation
      Then I see details about the reservation
       And I see the message 'Reservation updated.'
       And I see no errors
