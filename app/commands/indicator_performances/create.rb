# frozen_string_literal: true

module Commands
  module IndicatorPerformances
    class Create < Commands::Base
      def call
        step :validate_params, proc { err(nil, "Params error") }
        step :init_model
        step :save_model, proc { err(options[:model].errors.to_hash, 'Validation error') }
      end

      private

      def validate_params
        options.key?(:player_id) && options.key?(:indicator_id) && options.key?(:match_id)
      end

      def init_model
        options[:model] = IndicatorPerformance.new
      end

      def save_model
        options[:model].transaction do
          begin
            options[:model].assign_attributes(params)
            options[:model].save!
          rescue ActiveRecord::RecordInvalid
            raise ActiveRecord::Rollback
          end
        end
      end

      def params
        options.slice(:player_id, :indicator_id, :match_id)
      end
    end
  end
end
