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

Then /^a confirmation message should be sent to "(.*)"$/ do |email|
  user = User.find_by_email(email)
  sent = ActionMailer::Base.deliveries.first
  assert_equal [user.email], sent.to
  assert_match /confirm/i, sent.subject
  assert !user.confirmation_token.blank?
end

When /^I follow the confirmation link sent to "(.*)"$/ do |email|
  visit new_user_confirmation_path(:confirmation_token   => User.find_by_email(email).confirmation_token)
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

Given /^I am signed in$/ do                                                                                                                                                           
  pending # express the regexp above with the code you wish you had                                                                                                                    
end 


