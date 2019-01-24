require_relative "sql_literal.rb"
module Utils
    
    private

    def resolve_type(register)
        return register.instance_of?(String) ? SqlLiteral.new(register) : register
    end

end