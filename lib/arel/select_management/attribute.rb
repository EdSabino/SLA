require_relative "operators.rb"
require_relative "../utils.rb"

class Attribute
    include Utils

    attr_accessor :name, :table

    def initialize(table, name)
        @table = resolve_type(table)
        @name = name.to_s
    end

    def eq(right)
        Condition.new(Operators.new(self, right, "="))
    end

    def in(right)
        Condition.new(Operators.new(self, right, "IN"))
    end

    def get_result_string
        self.table.get_result_string + "." + self.name
    end
end