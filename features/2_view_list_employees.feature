Feature: View a list of employees
  As Individual-Employer
  So that I can see list of my employees and status
  I want to see my list of employee and status

  Background: 
    Given I am signed up and confirmed as "employer@perso.fr/monmotdepass"
    
  Scenario: Create a new employee with a contract
    Given I am on the home page
    When I go to register a new employee
    And I register a new employee with "isabel/isabel@monmail.fr/8.01/01/02/2014"
    Then I should see "isabel" and "isabel@monmail.fr" in the list
    And an email is sent to "isabel@monmail.fr"
    
  