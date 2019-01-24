require_relative "../utils.rb"
class Group
    include Utils

    attr_accessor :attribute

    def initialize(attribute)
        @attribute = resolve_type(attribute)
    end

    def get_result_string
        self.attribute.get_result_string
    end

end