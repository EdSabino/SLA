class SqlLiteral

    attr_accessor :expression

    def initialize(expression)
        @expression = expression
    end

    def get_result_string
        return self.expression
    end
end