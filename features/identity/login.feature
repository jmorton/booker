Feature: Login
  As a user I can log in
  so that I can use guest or owner features.

  Scenario: Sign in
     When I go to '/login'
      And I sign in
     Then I can use guest features
      And I can use owner features

  Scenario: Sign out
    When I sign out
     And I go to '/guest'
    Then I have to login
