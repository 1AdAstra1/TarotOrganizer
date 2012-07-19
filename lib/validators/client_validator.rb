class ClientValidator < ActiveModel::Validator
  include EntityValidations
  def validate(record)
    validate_name(record)
    date_past(record, :start_date)
  end
end
