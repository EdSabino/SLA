class Condition

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
        return self.left.get_result_string unless self.right
        self.left.get_result_string + concatenator + "(#{self.right.get_result_string})"
    end

end