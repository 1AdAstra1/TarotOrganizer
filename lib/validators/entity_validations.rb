module EntityValidations
  
  def validate_name(record)
    if record.name.empty? then
      record.errors.add(:name, :blank)
    end
  end
  
  def validate_date(record, date_field, future = false)
    date = record.send(date_field)
    if date == nil then
      record.errors.add(date_field, :blank)
    else
      if future == false
        if date > Date.today then
          record.errors.add(date_field, :future_date)
        end
      else
        if date < Date.today then
          record.errors.add(date_field, :past_date)
        end
      end
    end
  end
  
  def validate_existence(record, nested_resource)
    if record.send(nested_resource) == nil
      id_property = (nested_resource.to_s + '_id').to_sym
      record.errors.add(id_property, :nonexistent)
    end
  end
  
  def method_missing(method_name, *args)
    case method_name
    when /^date_(past|future|)/ then
      if $1 == 'past' then
        future = false
      else
        future = true
      end
      validate_date args[0], args[1], future
    when /^([a-z_]+)_exists/ then
      validate_existence(args[0], $1.to_sym)
    else
      super
    end    
  end
end