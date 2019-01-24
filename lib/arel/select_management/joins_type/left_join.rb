class LeftJoin

    attr_accessor :type

    def initialize
        @type = " LEFT JOIN "
    end

    def get_result_string
        self.type
    end

end