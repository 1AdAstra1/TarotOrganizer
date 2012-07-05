#Declarative step for populating the clients table

Given /the following clients exist/ do |clients_table|
  clients_table.hashes.each do |client|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that client to the database here.
    new_client = Client.create!(client)
    Client.find_by_name(client[:name]).should be_true
  end
end

Then /I should (not )?see the following clients: (.*)/ do |unsee, clients_list|
  clients_list = clients_list.split(',')
  clients_list.each do |client|
    client.strip!
    if unsee == nil then     
      page.should have_xpath('//*', :text => client)
    else
      page.should_not have_xpath('//*', :text => client)
    end
  end
end

Then /I should see all of the clients/ do
  total_clients = Client.all.length
  page.should have_xpath("//table[@id='clients']/tbody/tr", :count => total_clients)
end

When /I sort clients by "([^"]*)"/ do |sort_link|
  click_link(sort_link)
end

When /^I filter clients by "(.*?)" in the name$/ do |search_string|
  fill_in('filter_name', :with => search_string) and click_button 'filter_apply'
end

When /I drop the list filters/ do 
  click_link('drop_filters')
end

When /I click (the button )?"([^"]+)" in the row with (.*)/ do |button, link, row_marker|
  cell = page.find(:xpath, "//table[@id='clients']/tbody/tr/td/*", :text => row_marker)
  if button == nil then
    link = cell.find(:xpath, "ancestor-or-self::tr[1]/td//a", :text => link)[:id]
    click_link(link)
  else
    button = cell.find(:xpath, "ancestor-or-self::tr[1]/td//input[@value='" + link + "']")[:id]
    click_button(button)
  end
  
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  page.body.rindex(e1).should < page.body.rindex(e2)
end

Then /I should be redirected to the (edit )?client page for (.*)/ do |edit, client|
  current_path = URI.parse(current_url).path
  if edit == nil then
    current_path.should =~ /clients\/\d+$/ and page.should have_xpath('//*', :text => client)
  else
    current_path.should =~ /clients\/\d+\/edit$/ and page.should have_xpath('//*', :text => client)
  end
end
