require_relative "attribute.rb"
require_relative "select_manager.rb"
require_relative "operators.rb"
require_relative "../resolver_db.rb"

class Table < ResolverDb
    attr_accessor :name

    def initialize(name)
        @name = name.to_s
    end

    def get_result_string
        self.visit
    end

    def attr(attribute_name)
        Attribute.new(self, attribute_name)
    end

    def select(expression)
        SelectManager.new().from(self).select(expression)
    end

    def where(expression)
        SelectManager.new().from(self).where(expression)
    end

    def joins(expression)
        SelectManager.new().from(self).joins(expression)
    end

end