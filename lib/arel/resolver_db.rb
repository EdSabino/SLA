require_relative "../../database/db_config.rb"
require_relative "visitor.rb"

class ResolverDb

    attr_accessor :db_config

    def return_type
        DbConfig.new().return_type
    end

    def visit
        Visitor.visit(self.return_type, self.class.to_s.downcase, self)
    end
end