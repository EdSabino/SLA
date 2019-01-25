require_relative "resolver_db.rb"

class When < ResolverDb

    attr_accessor :expression, :result, :case

    def initialize(case_father, expression)
        @expression = resolve_type(expression)
        @case = case_father
    end

    def then(result_case)
        self.result = resolve_type(result_case)
        self.case
    end

    def get_result_string
        self.visit
    end
end