# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

FIRST_NAMES = %w(Ivan Petr Andrew Alexander Stanislav Grigoriy Lev Dmitriy Nikita Vasiliy)
LAST_NAMES = %w(%Ivanov Sidorov Petrov Andreev Vasileev Smirnov Popov Kuznetcov Sokolov)

Indicator.create(Array.new(2) { |i| { name: "Indicator #{i}" } })
Team.create(Array.new(2) { |i| { name: "Team #{i}" } })

players_attributes = []
3.times { players_attributes.push({ first_name: FIRST_NAMES.sample, last_name: LAST_NAMES.sample, team_id: Team.first.id }) }
3.times { players_attributes.push({ first_name: FIRST_NAMES.sample, last_name: LAST_NAMES.sample, team_id: Team.second.id }) }

Player.create(players_attributes)

team_ids = Team.ids
matches_attributes = []
3.times do |i|
  first_team_id = team_ids.sample
  second_team_id = team_ids.reject { |id| id == first_team_id }.sample

  matches_attributes.push({ name: "Match #{i}", first_team_id: first_team_id, second_team_id: second_team_id, first_team_score: rand(5), second_team_score: rand(5) })
end

Match.create(matches_attributes)

indicator_performances_attributes = []
10.times do
  player = Player.order("RANDOM()").reload.first
  match_id = player.team.match_ids.sample
  indicator_performances_attributes.push({ player_id: player.id, indicator_id: Indicator.ids.sample, match_id: match_id })
end
IndicatorPerformance.create(indicator_performances_attributes.uniq)