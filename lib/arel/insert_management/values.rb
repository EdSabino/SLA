require_relative "../sql_literal.rb"

class Values < ResolverDb

    attr_accessor :values

    def initialize(args)
        @values = []
        args.each { |val| @values << SqlLiteral.new(val)}
    end

    def get_result_string
        self.visit
    end

end