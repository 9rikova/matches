FactoryBot.define do
  factory :indicator do
    sequence(:name) { |n| "indicator #{n}" }
  end
end