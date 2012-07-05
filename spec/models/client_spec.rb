require 'spec_helper'

describe Client do
  describe 'adding new clients' do
    it 'should save properly formed items' do
      good_client = FactoryGirl.build(:client, :name => 'John Doe', :comment => 'Test comment')
      good_client.save.should be_true
    end
    
    it 'should reject clients with empty name' do
      bad_client = FactoryGirl.build(:client, :name => '', :comment => 'Test comment')
      bad_client.save.should be_false
    end
  end
end
