Feature: Create and Edit my employer account
  As visitor
  So that I can create an account as employer and modify it
  I want to create a new account as employer and modify it 

  Scenario Outline: Creating a new account
    Given I am not signed in
    When I go to register 
    # define this path mapping in features/support/paths.rb, usually as '/users/sign_up'
    And I fill in "user_email" with "<email>"
    And I fill in "user_password" with "<password>"
    And I fill in "user_password_confirmation" with "<password>"
    And I press "Sign up"
    Then I should see "A message with a confirmation link has been sent to your email address" 
    And a confirmation message should be sent to "<email>"
    Then I go to login
    And I fill in "user_email" with "<email>"
    And I fill in "user_password" with "<password>"
    And I press "Sign in"
    Then I should see "Didn't receive confirmation instructions"
    When I follow the confirmation link sent to "<email>"
    Then I should see "Your account was successfully confirmed"
    And I should see "Logged in as <email>"    

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
