Feature: display client's profile with all client's spreads
 
  As a competent fortune teller
  I want to see  the full profile of my client
  So that I can see who my clients are and what readings I did for them

Background: clients have been added to database

  Given the following clients exist:
  | name                   | start_date | comment |
  | John Doe               | 2012-01-03	| Dumb idiot, but pays a lot of money |
  | Harry Potter           | 2012-02-04	| Little cute schoolboy, mmmmm |

  And the following spreads exist:
  | name			| client_name	| structure		| date 			| comment		| feedback		|
  | test spread 	| John Doe		| {aa:'bb'} 	| 2012-01-05	| this is a test| none			|	
  | test spread 2	| John Doe		| {aa:'cc'} 	| 2012-01-06	| this is a test| 				|
  | very magical	| Harry Potter	| {aa:'666'} 	| 2012-07-03	| hocus pocus	| very good!	|		
		
Scenario: show the list of clients
  When I view John Doe's profile
  Then I should see the following spreads: test spread, test spread 2
  And I should not see the following spreads: very magical
  
Scenario: leaving this page to view a spread
  When I view John Doe's profile
  And I follow "2012-01-05"
  Then I should be redirected to the spread page for test spread