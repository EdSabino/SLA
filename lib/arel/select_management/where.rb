require_relative "../utils.rb"
require_relative "resolver_db.rb"

class Where < ResolverDb
    include Utils

    attr_accessor :expression

    def initialize(expression)
        @expression = resolve_type(expression)
    end

    def get_result_string
        self.visit
    end
end