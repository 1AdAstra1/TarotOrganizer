class Spread < ActiveRecord::Base
  belongs_to :client
  attr_protected :client_id
end
