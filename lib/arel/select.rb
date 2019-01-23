class Select
    attr_accessor :symbol, :expression

    def initialize(expression)
        @expression = expression
    end

    def get_result_string
        if self.expression.instance_of?(String)
            return self.expression
        else
            return self.expression.get_result_string
        end
    end
end