require_relative "condition.rb"
require_relative "../sql_literal.rb"
require_relative "../utils.rb"
class Operators
    include Utils

    attr_accessor :left, :right, :operator

    def initialize(left, right, operator)
        @left = left
        @right = resolve_type(right)
        @operator = operator
    end

    def get_result_string
        self.left.get_result_string + " " +  self.operator + " " + "(#{self.right.get_result_string})"
    end

end