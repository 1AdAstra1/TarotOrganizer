class ClientValidator < ActiveModel::Validator
  include EntityValidations
  def validate(record)
    validate_name(record)
    date_past(record, :start_date)
  end

  def validate_name(record)
    if record.name.empty? then
      record.errors.add(:name, :blank)
    end
  end

end
