class Client < ActiveRecord::Base
  extend ModelsCommon
  include EntitiesCommon
  has_many :spreads, :dependent => :destroy
  belongs_to :user
  validates_with ClientValidator
  def self.method_missing(method_name, *args)
    super
  rescue NoMethodError
    case method_name
    when /^search_in_(\w+)/ then
      self.search $1, args[0], args[1]
    else
      raise
    end    
  end

  def self.search(attr, user_id, substr)
    items = self.where(self.arel_table[attr].matches("%#{substr}%")).find_user_items(user_id)
    return items
  end  
end
