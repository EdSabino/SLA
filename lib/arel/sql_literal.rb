require_relative "select_management/resolver_db.rb"

class SqlLiteral < ResolverDb

    attr_accessor :expression

    def initialize(expression)
        @expression = expression
    end

    def get_result_string
        self.visit
    end
end