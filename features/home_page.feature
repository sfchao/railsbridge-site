Feature: Home page
  In order to tell people about RailsBridge
  The home page should show some info

Scenario: home page displays tagline
    When I go to the homepage
    Then I should see "First, do no harm. Then, help where you can."
