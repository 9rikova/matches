# frozen_string_literal: true

module Players
  class CheckIndicator
    attr_reader :resource, :indicator_id, :times, :matches_number
    def initialize(resource, indicator_id:, times: 1, matches_number: 5)
      @resource = resource
      @indicator_id = indicator_id
      @times = times
      @matches_number = matches_number
    end

    def call
      indicator_performances_count >= times
    end

    private

    def last_match_ids
      resource.team.matches.last(matches_number).pluck(:id)
    end

    def indicator_performances_count
      IndicatorPerformance.where(match_id: last_match_ids, player_id: resource.id, indicator_id: indicator_id).count
    end
  end
end
