require_relative "../../resolver_db.rb"

class FullOuterJoin < ResolverDb

    def get_result_string
        self.visit
    end

end