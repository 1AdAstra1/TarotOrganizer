require 'spec_helper'

describe Spread do
  describe 'when adding or editing' do
    before :each do
      @client = Client.create({:name => 'test', :comment => 'test', :start_date => '2010-11-21'})
      @client.save
    end
    it 'should save properly formed entries' do
      good_spread = Spread.create({:name => 'test spread', :client_id => @client.id, :structure => '{"aaa":"bbb"}', :comment => 'test spread', :date => '2010-11-21'})
      good_spread.save.should be_true
    end
    it 'should reject entries with empty name' do
      bad_spread = Spread.create({:name => '', :client_id => @client.id, :structure => '{"aaa":"bbb"}', :comment => 'test spread', :date => '2010-11-21'})
      bad_spread.save.should be_false
    end
    it 'should reject entries with date in the future' do
      bad_spread = Spread.create({:name => '11111', :client_id => @client.id, :structure => '{"aaa":"bbb"}', :comment => 'test spread', :date => '2015-11-21'})
      bad_spread.save.should be_false
    end  
    it 'should reject entries with nonexistent client ID' do
      bad_spread = Spread.create({:name => '11111', :client_id => 100500, :structure => '{"aaa":"bbb"}', :comment => 'test spread', :date => '2011-11-21'})
      bad_spread.save.should be_false
    end
    it 'should reject non-JSON spread structure' do
      bad_spread = Spread.create({:name => '11111', :client_id => @client.id, :structure => '111dfgdfgdfgf', :comment => 'test spread', :date => '2011-11-21'})
      bad_spread.save.should be_false
    end
    
  end
end
