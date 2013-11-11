Given /^I am signed up and confirmed as "(.*)\/(.*)"$/ do |email, password|
  user = Factory :email_confirmed_user,
    :email                 => email,
    :password              => password,
    :password_confirmation => password
end

