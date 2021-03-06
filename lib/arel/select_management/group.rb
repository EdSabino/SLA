require_relative "../resolver_db.rb"
require_relative "../utils.rb"

class Group < ResolverDb
    include Utils

    attr_accessor :attribute

    def initialize(attribute)
        @attribute = resolve_type(attribute)
    end

    def get_result_string
        self.visit
    end

end