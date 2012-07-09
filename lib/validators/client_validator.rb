class ClientValidator < ActiveModel::Validator
  def validate(record)
    validate_name(record)
    validate_start_date(record)
  end

  def validate_name(record)
    if record.name.empty? then
      record.errors.add(:name, :blank)
    end
  end

  def validate_start_date(record)
    if record.start_date == nil then
      record.errors.add(:start_date, :blank)
    else
      if record.start_date > Date.today then
        record.errors.add(:start_date, :future_date)
      end
    end
  end
end
