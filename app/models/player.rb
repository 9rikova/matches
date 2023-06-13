class Player < ApplicationRecord
  belongs_to :team
  has_many :indicator_performances
end
