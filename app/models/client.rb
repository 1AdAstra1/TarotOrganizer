class Client < ActiveRecord::Base
  validates_with ClientValidator
  
  def self.search_in_name(substr)
    return self.where(self.arel_table[:name].matches("%#{substr}%"))
  end
end
