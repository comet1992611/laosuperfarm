module Routes
  class ParamsConstraint
    def initialize(params = {})
      @params = params.stringify_keys
    end

    def matches?(request)
      !@params.detect do |key, value|
        value != request.query_parameters[key] && value != request.request_parameters[key]
      end
    end
  end
end

module ActionDispatch
  module Routing
    class Mapper
      def params(*args)
        Routes::ParamsConstraint.new(*args)
      end
    end
  end
end
