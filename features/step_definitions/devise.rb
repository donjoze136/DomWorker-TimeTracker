
Given /^I am not signed in$/ do
  page.driver.submit :delete, "/users/sign_out", {}
end

Given /^I am not authenticated$/ do
  visit('/users/sign_out') 
  # ensure that at least
end

Given /^I am a new authenticated user$/ do
  email = 'stephane@f-paris.org'
  password = 'secretpass'
  User.new(:email => email, :password => password, :password_confirmation => password).save!

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"

end


# ----------------------------------------
# general

Then /^I should see error messages$/ do
  if respond_to?(:page)
    assert_match /error(s)? prohibited/m, page.body
  else
    assert_match /error(s)? prohibited/m, response.body
  end
end

# -----------------------------------------
# Database

Given /^no user exists with an email of "(.*)"$/ do |email|
  assert_nil User.find_by_email(email)
end

Given /^I signed up with "(.*)\/(.*)"$/ do |email, password|
  user = Factory :user,
    :email                 => email,
    :password              => password,
    :password_confirmation => password
end 

Given /^I am signed up and confirmed as "(.*)\/(.*)"$/ do |email, password|
  user = Factory :email_confirmed_user,
    :email                 => email,
    :password              => password,
    :password_confirmation => password
end

# -----------------------------------------
# Session

Then /^I should be signed in as "([^\"]*)"$/ do |email|
  Given %{I am on the homepage}
  Then %{I should see "#{email}" within ".navbar-aoi"}
 end

Then /^I should be signed out$/ do
  Given %{I am on the homepage}
  Then %{I should see "Log In"}
end

When /^session is cleared$/ do
  request.reset_session
  controller.instance_variable_set(:@_current_user, nil)
end

Given /^I have signed in with "(.*)\/(.*)"$/ do |email, password|
  Given %{I am signed up and confirmed as "#{email}/#{password}"}
  And %{I sign in as "#{email}/#{password}"}
end

# -------------------------------------
# Actions

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Log In"}
end

When /^I sign out$/ do
  visit '/sign_out'
end

When /^I request password reset link to be sent to "(.*)"$/ do |email|
  When %{I go to the password reset request page}
  And %{I fill in "Email" with "#{email}"}
  And %{I press "Reset password"}
end

When /^I update my password with "(.*)\/(.*)"$/ do |password, confirmation|
  And %{I fill in "Password" with "#{password}"}
  And %{I fill in "Password Confirmation" with "#{confirmation}"}
  And %{I press "Save this password"}
end

Then /^I fill in the register form with "(.*)" and "(.*)"$/ do  |email, password|
  step(%{I fill in "user_email" with "#{email}"})
  step(%{I fill in "user_password" with "#{password}"})
  step(%{I fill in "user_password_confirmation" with "#{password}"})
  step(%{I press "Sign up"})
end

Then /^I should see a confirmation page with email sent to "(.*)" to confirm$/ do |email|
  step(%{I should see "A message with a confirmation link has been sent to your email address"})
  user = User.find_by_email(email)
  sent = ActionMailer::Base.deliveries.first
  assert_equal [user.email], sent.to
  assert_match /confirm/i, sent.subject
  assert !user.confirmation_token.blank?
end

When /^I follow the confirmation link sent to "(.*)"$/ do |email|
  visit user_confirmation_path(:confirmation_token  => User.find_by_email(email).confirmation_token )
end

Then /^I am redirected to "([^\"]*)"$/ do |url|
  assert [301, 302].include?(@integration_session.status), "Expected status to be 301 or 302, got #{@integration_session.status}"
  location = @integration_session.headers["Location"]
  assert_equal url, location
  visit location
end

When /^I want to edit my account$/ do
  visit('/users/edit')
end



