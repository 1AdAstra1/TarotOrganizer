Feature: adding and editing clients
 
  As a competent fortune teller
  I want to add and update client information
  So that I can keep it up-to-date and consistent

Background: clients have been added to database

  Given the following clients exist:
  | name                   | start_date | comment |
  | Cheburashka            | 2012-03-06	| Fantasy creature |
  
Scenario: filling the client form and saving data
  When I am on the new client page
  And I fill the form with values: "Вася Пупкин" for client_name, "Просто Вася" for client_comment
  And I set "21 декабря 2011" as client_start_date
  And I submit the form
  Then I should be redirected to the client page for Вася Пупкин
  