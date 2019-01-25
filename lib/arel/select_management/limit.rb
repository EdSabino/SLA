require_relative "resolver_db.rb"

class Limit < ResolverDb

    attr_accessor :number

    def initialize(num)
        @number = num
    end

    def get_result_string
        self.visit
    end

end