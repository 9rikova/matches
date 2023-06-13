class IndicatorPerformancesController < ApplicationController
  def create
    op = ::Commands::IndicatorPerformances::Create.new(params.to_unsafe_h).call

    respond_with_op(op, IndicatorPerformanceSerializer)
  end
end
