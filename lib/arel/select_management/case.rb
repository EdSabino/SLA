require_relative "resolver_db.rb"
require_relative "when.rb"
require_relative "../utils.rb"

class Case < ResolverDb
    include Utils

    attr_accessor :attribute, :else, :whens

    def initialize(attribute)
        @attribute = resolve_type(attribute)
        @whens = []
    end

    def when(expression)
        when_new = When.new(self, expression)
        self.whens << when_new
        return when_new
    end

    def else(result)
        self.else = resolve_type(result)
        self
    end

    def get_result_string
        self.visit
    end

end