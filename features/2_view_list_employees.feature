Feature: View a list of employees
  As Individual-Employer
  So that I can see list of my employees and status
  I want to see my list of employee and status

  Background: 
    Given I am signed up and confirmed as "employer@perso.fr/monmotdepass"
    And I have employees:
    | name               | email                 | status      | hourly_rate | start_day | start_month | start_year |
    | Isabel GONZALES    | isabel@monemail.fr    | confirmed   | 12.01       | 1         | 2           | 2014       |
    | Magalie CHENOT     | mag@provider.fr       | confirmed   | 8.01        | 1         | 1           | 2014       |
    | Marc MACHIN        | marc@machin.fr        | waiting     | 11.35          | 15        | 1           | 2014       |
     
  Scenario: List employees
    Given I am on the home page
    Then I should see employee "Marc MACHIN" with status "waiting"
    And I should see employee "Isabel GONZALES" with status "confirmed"
    
  