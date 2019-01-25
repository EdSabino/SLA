require_relative "db_types/require_db_visitors.rb"
class Visitor

    def self.visit(class_passed, method, obj)
        Object.const_get("#{class_passed.capitalize}Visitor").new().send("accept_#{method}", obj)
    end

end