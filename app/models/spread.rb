class Spread < ActiveRecord::Base
  require 'json'
  belongs_to :client
  validates_with SpreadValidator
  before_save :generate_image
  
  def generate_image
    image = SpreadImage.new(self)
    image.render
    self.image = image.path
  end
  
end
