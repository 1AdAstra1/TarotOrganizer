module EntitiesCommon

  def method_missing(method_name, *args)
    super
  rescue NoMethodError
    case method_name
    when /^print_(\w+)/ then
      print $1
    else
      raise
    end    
  end

  def print(attr)
    attr_text = CGI::escapeHTML(self.send(attr.to_sym))
    attr_text.gsub!(/\n/, '<br />')
    return attr_text
  end
  
end