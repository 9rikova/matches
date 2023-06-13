# frozen_string_literal: true

module Queries
  module Players
    class Fetch < Queries::Base

      def call
        @scope = get_by_team_collection
        @scope = sort_by_indicator_collection
      end

      private

      def get_by_team_collection
        return @scope unless @params[:team_id].present?

        @scope.where(team_id: @params[:team_id])
      end

      def sort_by_indicator_collection
        sort = @params[:sort]
        indicator_id = @params[:indicator_id]

        return @scope if sort != 'indicator' || indicator_id.nil?

        direction = @params[:direction] || 'DESC'
        @scope.from(
          @scope
            .joins(:indicator_performances)
            .where(indicator_performances: { indicator_id: indicator_id })
            .group("players.id, indicator_performances.indicator_id")
            .select("players.*, COUNT(indicator_performances.indicator_id) AS indicator_count")
            .order("indicator_count #{direction}"),
          'players'
        )
      end
    end
  end
end
