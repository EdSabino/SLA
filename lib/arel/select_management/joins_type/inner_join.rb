class InnerJoin

    attr_accessor :type

    def initialize
        @type = " INNER JOIN "
    end

    def get_result_string
        self.type
    end

end