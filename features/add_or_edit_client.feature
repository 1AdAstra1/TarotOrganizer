Feature: adding and editing clients
 
  As a competent fortune teller
  I want to add and update client information
  So that I can keep it up-to-date and consistent

Background: clients have been added to database

  Given the following users exist:
  | email 					| password		| password_confirmation		|
  | example@example.com		| gotohell		| gotohell					|

  And the following clients exist:
  | name                   | start_date | comment 					| user 					|
  | Cheburashka            | 2012-03-06	| Fantasy creature 			| example@example.com	|	
  
  And I am logged in as example@example.com
  
Scenario: filling the client form and saving data
  When I am on the new client page
  And I fill the form with values: "Вася Пупкин" for client_name, "Просто Вася" for client_comment
  And I set "21 декабря 2011" as client_start_date
  And I submit the form
  Then I should be redirected to the client page for Вася Пупкин
  