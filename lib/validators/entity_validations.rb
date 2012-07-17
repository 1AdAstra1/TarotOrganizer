module EntityValidations
  def validate_date(record, date_field, future = false)
    date = record.send(date_field)
    if date == nil then
      record.errors.add(:start_date, :blank)
    else
      if future == false
        if date > Date.today then
          record.errors.add(:start_date, :future_date)
        end
      else
        if date > Date.today then
          record.errors.add(:start_date, :past_date)
        end
      end
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
    else
      super
    end    
  end
end