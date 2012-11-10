def populate_table (table, model)
  table.hashes.each do |item|
  # each returned element will be a hash whose key is the table header.
  # you should arrange to add that client to the database here.
    new_item = model.create!(item)
    model.find_by_name(item[:name]).should be_true
  end
end

#Declarative step for populating the clients table

Given /the following clients exist/ do |clients_table|
  populate_table(clients_table, Client)
end

#Declarative step for populating the spreads table

Given /the following spreads exist/ do |spreads_table|
  spreads_table.hashes.each do |item|
    name = item.delete('client_name')
    new_item = Spread.create(item)
    client = Client.find_by_name(name)
    client.spreads.push(new_item)
    client.save
    Spread.find_by_name(item[:name]).should be_true
  end
end

Given /the following users exist/ do |users_table|
  @added_users = {}
  users_table.hashes.each do |item|
    @added_users[item[:email]] = item
    User.create!(item).confirm!
  end
end

Given /I am logged in as (.*)/ do |user_email|
  user = @added_users[user_email];
  visit('/users/sign_in');
  fill_in("user_email", :with => user[:email])
  fill_in("user_password", :with =>user[:password])
  click_button("Sign in")
end

def group_exists(unsee, list, xpath='//*')
  list = list.split(',')
  list.each do |item|
    item.strip!
    if unsee == nil then
      page.should have_xpath(xpath, :text => item)
    else
      page.should_not have_xpath(xpath, :text => item)
    end
  end
end

Then /I should (not )?see the following clients: (.*)/ do |unsee, clients_list|
  group_exists(unsee, clients_list)
end

Then /I should (not )?see the following spreads: (.*)/ do |unsee, spreads_list|
  group_exists(unsee, spreads_list, '//*')
end


Then /I should see all of the clients/ do
  total_clients = Client.all.length
  page.should have_xpath("//table[@id='clients']/tbody/tr", :count => total_clients)
end

When /I sort clients by "([^"]+)"/ do |sort_link|
  click_link(sort_link)
end

When /^I filter clients by "([^"]+)" in the name$/ do |search_string|
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

When /I fill the form with values: (.*)/ do |values|
  pairs = values.split(',')
  pairs.each do |str|
    str.strip!
    matches = /"([^"]+)" for (.*)/.match(str)
    fill_in(matches[2], :with => matches[1])
  end
end

When /I set "([^"]+)" as (.*)/ do |date, date_select|
  matches = /(?<day>\d{2}) (?<month>\p{Word}+) (?<year>\d{4})/u.match(date)
  select(matches[:day], :from => date_select + '_3i')
  select(matches[:month], :from => date_select + '_2i')
  select(matches[:year], :from => date_select + '_1i')
end

When /I submit the form/ do
  input = page.find(:xpath, "//input[@name='commit']")
  click_button(input[:value])
end

When /I view ([^']+)'s profile/ do |name|
  client = Client.find_by_name(name)
  visit client_path(client)
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
#  ensure that that e1 occurs before e2.
#  page.content  is the entire content of the page as a string.
  page.body.rindex(e1).should < page.body.rindex(e2)
end

Then /I should be redirected to the (edit )?(\w+) page for (.*)/ do |edit, model, name|
  current_path = URI.parse(current_url).path
  if edit == nil then
    current_path.should =~ /#{model}s\/\d+$/ and page.should have_xpath('//*', :text => name)
  else
    current_path.should =~ /#{model}s\/\d+\/edit$/ and page.should have_xpath('//*', :text => name)
  end
end

Then /^I should be adding a new spread for (.*)$/ do |client_name|
  client_id = Client.find_by_name(client_name).id
  current_path.should =~ /clients\/#{client_id}\/spreads\/new$/ and page.should have_xpath('//*', :text => client_name)
end

Then /^"([^"]*)" should be selected for "([^"]*)"$/ do |value, field|
  field_labeled(field).native.xpath(".//option[@selected = 'selected']").inner_html.should =~ /#{value}/ 
end

