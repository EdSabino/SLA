require_relative "../resolver_db.rb"
require_relative "../utils.rb"

class Select < ResolverDb
    include Utils

    attr_accessor :symbol, :expression

    def initialize(expression)
        @expression = resolve_type(expression)
    end

    def get_result_string
        self.visit
    end
end