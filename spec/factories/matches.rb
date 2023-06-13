FactoryBot.define do
  factory :match do
    sequence(:name) { |n| "match #{n}" }

    trait :with_teams do
      association :first_team, :with_players, factory: :team
      association :second_team, :with_players, factory: :team
    end
  end
end
