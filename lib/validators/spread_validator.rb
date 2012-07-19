class SpreadValidator < ActiveModel::Validator
  include EntityValidations
  require 'json'
  def validate(record)
    validate_name(record)
    date_past(record, :date)
    client_exists(record)
    structure_json(record)
  end
  
  def validate_json(record, field)
    parse_result = JSON.parse(record.send(field))
  rescue JSON::ParserError
    record.errors.add(field, :bad_format)
  end
  
  def method_missing(method_name, *args)
    case method_name
    when /^([a-z_]+)_json/ then
      validate_json(args[0], $1.to_sym)
    else
      super
    end   
  end
end
