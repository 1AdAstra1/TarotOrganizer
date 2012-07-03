#Declarative step for populating the clients table

Given /the following clients exist/ do |clients_table|
  clients_table.hashes.each do |client|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that client to the database here.
    new_client = Client.create!(client)
    Client.find_by_name(client[:name]).should be_true
  end
end

Then /I should see all of the clients/ do
  total_clients = Client.all.length
  page.should have_xpath("//table[@id='clients']/tbody/tr", :count => total_clients)
end

When /I sort clients by "([^"]*)"/ do |sort_link|
  click_link(sort_link)
end

When /I drop the list filters/ do 
  click_link('drop_filters')
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  page.body.rindex(e1).should < page.body.rindex(e2)
end