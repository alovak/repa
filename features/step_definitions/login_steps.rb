# -*- coding: utf-8 -*-
When /^I log in as "([^\"]*)" with "([^\"]*)"$/ do |email, password|
  steps %Q{
    When I go to login page
    When I fill in "email" with "#{email}"
    And I fill in "password" with "#{password}"
    And I press "Войти"
  }
end
