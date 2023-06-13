class Team < ApplicationRecord
  has_many :matches, ->(team) { unscope(where: :team_id).where(first_team_id: team.id).or(where(second_team_id: team.id)) }, class_name: 'Match'
  has_many :players
  validates :name, presence: true
end
