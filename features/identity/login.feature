Feature: Login

  As a Visitor I can log in
  So that I can use guest or owner features.

  Scenario: Access guest features
     When I go to '/guest'
      And I sign in
     Then I see "Your Reservations"

  Scenario: Access owner features
     When I go to '/owner'
      And I sign in
     Then I see "Manage Your Units"
      And I see "Reservations for Your Units"

  Scenario: Sign out
    Given I sign out
     When I go to '/guest'
     Then I have to login
     When I go to '/owner'
     Then I have to login
