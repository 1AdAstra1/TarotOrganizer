class Spread < ActiveRecord::Base
  require 'json'
  belongs_to :client
  validates_with SpreadValidator
  after_save :generate_image

  def generate_image
    image = SpreadImage.new(self)
    image.render
    Spread.skip_callback(:save, :after, :generate_image)
    self.update_column(:image, image.path)
    Spread.set_callback(:save, :after, :generate_image)
  end

end
