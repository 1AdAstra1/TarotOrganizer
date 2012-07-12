# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client do
    name "John Doe"
    comment "Dummy character"
    start_date "2010-11-11"
  end
end
