require_relative "../select_management/attribute.rb"
require_relative "../resolver_db.rb"

class Attributes < ResolverDb

    attr_accessor :attrs

    def initialize(attrs)
        @attrs = []
        attrs.each { |att| @attrs << Attribute.new(att)}
    end

    def get_result_string
        self.visit
    end

end