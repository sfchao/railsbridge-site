Feature: Home page
  In order to tell people about RailsBridge
  The home page should show some info

Scenario: home page displays tagline
    When I go to the english homepage
    Then I should see "First, do no harm. Then, help where you can."

Scenario: home page displays tagline in spanish
    When I go to the spanish homepage
    Then I should see "Primero, no hagas daño. Entonces, ayuda dónde puedas."
