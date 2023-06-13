class Indicator < ApplicationRecord
  has_many :indicator_performances
  validates :name, uniqueness: true
end
