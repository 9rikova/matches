# frozen_string_literal: true

class IndicatorPerformanceSerializer  < Blueprinter::Base
  field(:match_name) { |obj| obj.match.name }
  field(:player_last_name) { |obj| obj.player.last_name }
  field(:indicator_name) { |obj| obj.indicator.name }
end
