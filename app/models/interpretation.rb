class Interpretation < ActiveRecord::Base
  extend DecksCommon
  attr_accessible :card_code, :text
  validates :card_code, :presence => true, :inclusion => { :in => common_deck_structure }
  validates :text, :presence => true
end
