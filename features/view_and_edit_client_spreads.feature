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
  | test spread 	| John Doe		| {"width":"497px","height":"262px","border":"","backgroundColor":"rgb(73, 109, 73)","deck":"rider-waite","size":"large","positions":[{"width":"173px","height":"123px","position":"absolute","top":"59px","left":"50px","fontSize":"24px","textAlign":"center","backgroundColor":"rgb(238, 238, 238)","border":"","number":{"value":1,"mode":"horizontal","textAlign":"left","position":"relative","top":"61.5px","marginTop":"-12px","marginLeft":"10px","marginRight":"10px"},"description":"rderyrwety","card":{"image":"/assets/rider-waite/lovers.jpg","width":66,"height":115,"reverted":true,"id":"lovers","name":"Влюблённые","value":"retyretyrety rtyretyer","marginTop":"3px","marginBottom":"3px"}},{"width":"123px","height":"173px","position":"absolute","top":"61px","left":"325px","fontSize":"24px","textAlign":"center","backgroundColor":"rgb(238, 238, 238)","border":"","number":{"value":2,"mode":"vertical","textAlign":"center","position":"static","top":"auto","marginTop":"3px","marginLeft":"0px","marginRight":"0px"},"description":"rtyrtyrety","card":{"image":"/assets/rider-waite/cups-8.jpg","width":80,"height":140,"reverted":false,"id":"cups-8","name":"8 Чаш","value":"111","marginTop":"0px","marginBottom":"0px"}}]} 	| 2012-01-05	| this is a test| none			|	
  | test spread 2	| John Doe		| {"width":"497px","height":"262px","border":"","backgroundColor":"rgb(73, 109, 73)","deck":"rider-waite","size":"large","positions":[{"width":"173px","height":"123px","position":"absolute","top":"59px","left":"50px","fontSize":"24px","textAlign":"center","backgroundColor":"rgb(238, 238, 238)","border":"","number":{"value":1,"mode":"horizontal","textAlign":"left","position":"relative","top":"61.5px","marginTop":"-12px","marginLeft":"10px","marginRight":"10px"},"description":"rderyrwety","card":{"image":"/assets/rider-waite/lovers.jpg","width":66,"height":115,"reverted":true,"id":"lovers","name":"Влюблённые","value":"retyretyrety rtyretyer","marginTop":"3px","marginBottom":"3px"}},{"width":"123px","height":"173px","position":"absolute","top":"61px","left":"325px","fontSize":"24px","textAlign":"center","backgroundColor":"rgb(238, 238, 238)","border":"","number":{"value":2,"mode":"vertical","textAlign":"center","position":"static","top":"auto","marginTop":"3px","marginLeft":"0px","marginRight":"0px"},"description":"rtyrtyrety","card":{"image":"/assets/rider-waite/cups-8.jpg","width":80,"height":140,"reverted":false,"id":"cups-8","name":"8 Чаш","value":"111","marginTop":"0px","marginBottom":"0px"}}]}	| 2012-07-03	| hocus pocus	| very good!	|		
		
Scenario: show the list of clients
  When I view John Doe's profile
  Then I should see the following spreads: test spread, test spread 2
  And I should not see the following spreads: very magical
  
Scenario: leaving the list page to view a spread
  When I view John Doe's profile
  And I follow "2012-01-05"
  Then I should be redirected to the spread page for test spread
  
Scenario: leaving the list page to add a spread
  When I view Harry Potter's profile
  And I follow "add_spread_link"
  Then I should be adding a new spread for Harry Potter
  And "Harry Potter" should be selected for "spread_client_id"
