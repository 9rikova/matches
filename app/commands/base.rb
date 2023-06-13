# frozen_string_literal: true

module Commands
  class Base
    attr_accessor :error, :options

    def initialize(params)
      @success = true
      @options = params
    end

    def call
      raise NotImplementedError
    end

    def success?
      @success
    end

    def failure?
      !@success
    end

    def step(method, if_fail = nil)
      return self unless success?
      res = method.is_a?(Proc) ? method.call(self) : self.send(method)
      unless res
        @success = false
        unless if_fail.nil?
          if_fail.is_a?(Proc) ? if_fail.call(self) : self.send(if_fail)
        end
      end
      self
    end

    def err(data, message)
      @error = { data: data, message: message }
    end
  end
end
