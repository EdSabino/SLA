require_relative "../utils.rb"

class From
    include Utils

    attr_accessor :expression

    def initialize(expression)
        @expression = resolve_type(expression)
    end

    def get_result_string
        return self.expression.get_result_string
    end

end