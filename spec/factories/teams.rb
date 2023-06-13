FactoryBot.define do
  factory :team do
    sequence(:name) { |n| "Team #{n}" }

    trait :with_players do
      players { create_list(:player, 3, team: instance) }
    end
  end
end