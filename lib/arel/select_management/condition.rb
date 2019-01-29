require_relative "../resolver_db.rb"

class Condition < ResolverDb

    attr_accessor :left, :concatenator, :right

    def initialize(left)
        @left = left
    end

    def and(condition)
        self.concatenator = " AND "
        self.right = condition
        Condition.new(self)
    end

    def or(condition)
        self.concatenator = " OR "
        self.right = condition
        Condition.new(self)
    end

    def get_result_string
        self.visit
    end

end