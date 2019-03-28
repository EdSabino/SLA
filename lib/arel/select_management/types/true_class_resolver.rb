require_relative "../../resolver_db.rb"

class TrueClassResolver < ResolverDb
    attr_accessor :register

    def initialize(register)
        @register = register
    end

    def get_result_string
        self.visit
    end

end