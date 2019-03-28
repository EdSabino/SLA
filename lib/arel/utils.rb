require_relative "sql_literal.rb"
require_relative "select_management/types.rb"

module Utils
    
    private

    def resolve_type(register)
        if register.class < ResolverDb
            register
        elsif register.class == String
            SqlLiteral.new(register)
        else
            Types.new(register)
        end
    end

end