class SpreadImage
  attr_reader :path
  def initialize(spread)
    @id = spread.id || spread.client_id.to_s + spread.date.to_s
    @structure = JSON.parse(spread.structure)
    @path = ''
    @format = 'png'
    @dir = 'spread_images'
  end
  
  def render
    @path = '/' + @dir + '/spread_' + @id.to_s + '.' + @format
  end
end