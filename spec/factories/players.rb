FactoryBot.define do
  factory :player do
    sequence(:first_name) { |n| "firstname#{n}" }
    sequence(:last_name) { |n| "lastname#{n}" }
  end
end