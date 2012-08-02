class Spread < ActiveRecord::Base
  require 'json'
  belongs_to :client
  validates_with SpreadValidator
  before_save :get_image_path
  after_save :generate_image
  
  def generate_image
    image = SpreadImage.new(self)
    image.render
  end
  
  def get_image_path
    image = SpreadImage.new(self)
    self.image = image.path
  end
end
