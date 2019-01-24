require_relative "db_types/require_db_visitors.rb"
class Visitor

    def self.visit(class_passed, obj)
        Object.const_get("#{class_passed.capitalize}Visitor").new().accept(obj)
    end

end