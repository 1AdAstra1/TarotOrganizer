# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spread do
    user_id 1
    client_id 1
    name "MyString"
    date "2012-07-10"
    structure "MyString"
    comment "MyString"
    feedback "MyString"
  end
end
