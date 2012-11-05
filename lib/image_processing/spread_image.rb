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
    @path = '/assets/' + @dir + '/' + @filename
    
    @localdir = Rails.root.join('app', 'assets', 'images', @dir).to_s
    @localpath = @localdir + '/' + @filename
  end

  def render
    @structure['width'] = @structure['width'].to_i
    @structure['height'] = @structure['height'].to_i
    bgcolor = @structure['backgroundColor']
    @image = Image.new(@structure['width'], @structure['height']) {
      self.background_color = bgcolor
    }
    @structure['positions'].each do |position|
      render_position(position)
    end
    Dir.chdir(@localdir) do
    #test mode doesn't like RMagick and hangs up, so can't test for that
      if !Rails.env.test? then
      @image.write(@filename);
      end
    end

  end

  def render_position(position)
    position_image = Image.new(position['width'].to_i, position['height'].to_i) {
      self.background_color = position['backgroundColor']
    }
    position_image.border!(1, 1, "black")
    number_data = position['number']
    if(number_data['mode'] == 'horizontal') then number_data['marginTop'] = '0' end
    pos_number = Draw.new
    pos_number.annotate(position_image, 0, 0, number_data['marginLeft'].to_i, number_data['marginTop'].to_i, number_data['value'].to_s) {
      if(number_data['mode'] == 'vertical') then
        self.gravity = NorthGravity
      else
        self.gravity = WestGravity
      end
      self.fill = 'black'
      self.pointsize = position['fontSize'].to_i
    }
    @image.composite!(position_image, position['left'].to_i, position['top'].to_i, OverCompositeOp)
  end
  
  def render_card(position_image, card)
    
  end

end