class SpreadImage
  require 'RMagick'
  include Magick
  attr_reader :path, :localpath

  def initialize(spread)
    @id = spread.id
    @structure = JSON.parse(spread.structure)
    @path = ''
    @format = 'png'
    @dir = 'spread_images'
    @filename = 'spread_' + @id.to_s + '.' + @format
    @path = '/' + @dir + '/' + @filename
    @localdir = Rails.root.join('app', 'assets', 'images', @dir).to_s
    @localpath = @localdir + '/' + @filename
  end

  def render
    @structure['width'] = @structure['width'].to_i
    @structure['height'] = @structure['height'].to_i
    @image = Image.new(@structure['width'], @structure['height'])  
    Dir.chdir(@localdir) do
      #test mode doesn't like RMagick and hangs up, so can't test for that
      if !Rails.env.test? then
        @image.write(@filename);
      end 
    end
    
  end
  
end