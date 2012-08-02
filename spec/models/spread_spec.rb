# coding: utf-8
require 'spec_helper'

describe Spread do
  describe 'when adding or editing' do
    before :each do
      @client = Client.create({:name => 'test', :comment => 'test', :start_date => '2010-11-21'})
      @client.save
    end
    
    it 'should save properly formed entries', :fakefs => true do
      good_spread = Spread.create({:name => 'test spread', :client_id => @client.id, :structure => '{"aaa":"bbb"}', :comment => 'test spread', :date => '2010-11-21'})
      good_spread.save.should be_true
    end
    it 'should reject entries with empty name', :fakefs => true do
      bad_spread = Spread.create({:name => '', :client_id => @client.id, :structure => '{"aaa":"bbb"}', :comment => 'test spread', :date => '2010-11-21'})
      bad_spread.save.should be_false
    end
    it 'should reject entries with date in the future', :fakefs => true do
      bad_spread = Spread.create({:name => '11111', :client_id => @client.id, :structure => '{"aaa":"bbb"}', :comment => 'test spread', :date => '2015-11-21'})
      bad_spread.save.should be_false
    end  
    it 'should reject entries with nonexistent client ID', :fakefs => true do
      bad_spread = Spread.create({:name => '11111', :client_id => 100500, :structure => '{"aaa":"bbb"}', :comment => 'test spread', :date => '2011-11-21'})
      bad_spread.save.should be_false
    end
    it 'should reject non-JSON spread structure', :fakefs => true do
      bad_spread = Spread.create({:name => '11111', :client_id => @client.id, :structure => '111dfgdfgdfgf', :comment => 'test spread', :date => '2011-11-21'})
      bad_spread.save.should be_false
    end
    it 'should generate proper image from the JSON spread structure', :fakefs => true do
      good_spread = Spread.create({:name => 'test spread', :client_id => @client.id, :structure => '{"width":"750px","height":"450px","border":"","backgroundColor":"rgb(73, 109, 73)","deck":"thoth","size":"large","positions":[{"width":"123px","height":"173px","position":"absolute","top":"20px","left":"51px","fontSize":"24px","textAlign":"center","backgroundColor":"rgb(238, 238, 238)","border":"","number":{"value":1,"mode":"vertical","textAlign":"center","position":"static","top":"auto","marginTop":"0px","marginLeft":"0px","marginRight":"0px"},"description":"rderyrwety","card":{"image":"/assets/thoth/lovers.jpg","width":98,"height":140,"reverted":true,"id":"lovers","name":"Влюблённые","value":"retyretyrety rtyretyer","marginTop":"0px","marginBottom":"0px"}},{"width":"123px","height":"173px","position":"absolute","top":"43px","left":"273px","fontSize":"24px","textAlign":"center","backgroundColor":"rgb(238, 238, 238)","border":"","number":{"value":2,"mode":"vertical","textAlign":"center","position":"static","top":"auto","marginTop":"0px","marginLeft":"0px","marginRight":"0px"},"description":"rtyrtyrety","card":{"image":"/assets/thoth/cups-8.jpg","width":98,"height":140,"reverted":false,"id":"cups-8","name":"8 Чаш","value":"111","marginTop":"0px","marginBottom":"0px"}}]}', :comment => 'test spread', :date => '2010-11-21'})
      good_spread.save
      good_spread.image.should_not be_nil
    end
    
  end
end
