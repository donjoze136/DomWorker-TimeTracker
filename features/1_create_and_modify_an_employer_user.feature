Feature: Create and Edit my employer account
  As visitor
  So that I can create an account as employer and modify it
  I want to create a new account as employer and modify it 

  Scenario Outline: Creating a new account
    Given I am not signed in
    When I go to register 
    And I fill in the register form with "<email>" and "<password>"
    Then I should see a confirmation page with email sent to "<email>" to confirm
    
    Then I go to login
    And I fill in "user_email" with "<email>"
    And I fill in "user_password" with "<password>"
    And I press "Sign in"
    Then I should see "You have to confirm your account before continuing"
    
    When I follow the confirmation link sent to "<email>"
    #Then I should see "Your account was successfully confirmed"
    #And 
    Then I should see "Logged in as <email>"    

    Examples:
      | email                | password   |
      | stephane@f-paris.org | secretpass |
      | vendeur@f-paris.org  | fr33z3sfdr |


  Scenario: Editing my account
    Given I am signed in
    # beyond this step, your work!
    When I go to edit my account
    Then I should be on edit account form
    And I should see "Edit User Email Password"
    # And more view checking stuff
