# frozen_string_literal: true

module Queries
  class Base
    def initialize(scope, params: {})
      @params = params
      @scope = scope
    end

    def self.call(...)
      new(...).call
    end

    def call
      raise NotImplementedError
    end
  end
end
