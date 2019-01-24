require_relative "../sql_literal.rb"
require_relative "../utils.rb"
class Joins
    include Utils

    attr_accessor :destiny, :condition, :type

    def initialize(destiny, condition, type_passed=:inner)
        @destiny = resolve_type(destiny)
        @condition = resolve_type(condition)
        @type = resolve_type_join(type_passed)
    end

    def get_result_string
        " #{type.get_result_string} " + self.destiny.get_result_string + " ON " + self.condition.get_result_string
    end

    private

    def resolve_type_join(type_passed)
        return InnerJoin.new() if type_passed == :inner
        return FullOuterJoin.new() if type_passed == :full_outer_join
        return LeftJoin.new() if type_passed == :left_join
    end

end