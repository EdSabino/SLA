require_relative "../resolver_db.rb"
require_relative "types/require_types.rb"

class Types < ResolverDb
    attr_accessor :register, :register_resolver

    def initialize(register)
        @register = register
        @register_resolver = Object.const_get("#{register.class.to_s}Resolver").new(register)
    end

    def get_result_string
        self.register_resolver.get_result_string
    end

end