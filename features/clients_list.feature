Feature: display list of clients
 
  As a competent fortune teller
  I want to see the list of my clients
  So that I can quickly see who I've been doing Tarot spreads for

Background: clients have been added to database

  Given the following clients exist:
  | name                   | comment |
  | John Doe               | Dumb idiot, but pays a lot of money |
  | Harry Potter           | Little cute schoolboy, mmmmm |
  | Vasya Pupkin           | Some dude I met online |
  | Kuzya Tapochkin        | Wants a spread about his GF |
  | Cheburashka            | Fantasy creature |

  And I am on the clients page
  
Scenario: show the list of clients
  When I am on the clients page
  Then I should see all of the clients
  
Scenario: sort clients by name
  When I sort clients by "Имя"
  Then I should see "Cheburashka" before "Harry Potter"
  And I should see "Kuzya Tapochkin" before "Vasya Pupkin"
  
Scenario: filter clients by name
  When I filter clients by "kin" in the name
  Then I should see the following clients: Vasya Pupkin, Kuzya Tapochkin
  And I should not see the following clients: John Doe, Harry Potter, Cheburashka
  
Scenario: dropping filters
  When I drop the list filters
  Then I should see "John Doe" before "Harry Potter"
  And I should see all of the clients

Scenario: leaving this page for client view
  When I follow "John Doe"
  Then I should be redirected to the client page for John Doe
  
Scenario: leaving this page to edit a client
  When I click "Редактировать" in the row with Harry Potter
  Then I should be redirected to the edit client page for Harry Potter
  
Scenario: leaving this page to add a client
  When I follow "Добавить клиента"
  Then I should be on the new client page
 
Scenario: deleting a client
  When I click the button "Удалить" in the row with Cheburashka
  Then I should be on the clients page
  And I should not see the following clients: Cheburashka  