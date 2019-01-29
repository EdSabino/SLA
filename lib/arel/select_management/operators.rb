require_relative "condition.rb"
require_relative "../sql_literal.rb"
require_relative "../resolver_db.rb"
require_relative "../utils.rb"

class Operators < ResolverDb
    include Utils

    attr_accessor :left, :right, :operator

    def initialize(left, right, operator)
        @left = left
        @right = resolve_type(right)
        @operator = operator
    end

    def get_result_string
        self.visit
    end

end