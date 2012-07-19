class Spread < ActiveRecord::Base
  belongs_to :client
  validates_with SpreadValidator
end
