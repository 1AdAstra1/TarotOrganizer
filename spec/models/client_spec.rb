require 'spec_helper'

describe Client do
  describe 'when adding new entries' do
    it 'should save properly formed items' do
      good_client = FactoryGirl.build(:client, :name => 'John Doe', :comment => 'Test comment', :start_date => '2012-01-03')
      good_client.save.should be_true
    end
    
    it 'should reject records with empty name' do
      bad_client = FactoryGirl.build(:client, :name => '', :comment => 'Test comment', :start_date => '2012-01-03')
      bad_client.save.should be_false
    end
    
    it 'should reject records with dates empty or in the future' do
      bad_client = FactoryGirl.build(:client, :name => 'John Doe', :comment => 'Test comment', :start_date => '')
      bad_client.save.should be_false
      bad_client = FactoryGirl.build(:client, :name => 'John Doe', :comment => 'Test comment', :start_date => '2015-10-02')
      bad_client.save.should be_false
    end
    
    it 'should search clients by substring in the name' do
      clients = {
        :out => FactoryGirl.build(:client, :name => 'John Doe', :comment => 'Test comment', :start_date => '2012-01-03'), 
        :in => FactoryGirl.build(:client, :name => 'Harry Potter', :comment => 'Test comment', :start_date => '2012-01-03')
      }
      clients.each do |key, client|
        client.save!
      end
      search_clients = Client.search_in_name('arr')
      search_clients.should include clients[:in]
      search_clients.should_not include clients[:out]
    end
  end
  
  describe 'finding and printing records' do
    before(:all) do
      @items = {
        :multiline => FactoryGirl.build(:client, :comment => 'Test comment
        
        In 2 lines!')
      }
      @items.each do |key, item|
        item.save!
      end
    end
    
    after(:all) do
      Client.delete_all
    end
    
    it 'should auto-format newlines as HTML <br /> tags' do
      @items[:multiline].print_comment.should =~ /Test comment<br \/>\s+<br \/>\s+In 2 lines!/
    end
  end
end
