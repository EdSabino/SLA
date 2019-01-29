require_relative "../resolver_db.rb"
require_relative "../utils.rb"

class From < ResolverDb
    include Utils

    attr_accessor :expression

    def initialize(expression)
        @expression = resolve_type(expression)
    end

    def get_result_string
        self.visit
    end

end