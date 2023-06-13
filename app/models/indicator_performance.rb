class IndicatorPerformance < ApplicationRecord
  belongs_to :indicator
  belongs_to :player
  belongs_to :match
end
