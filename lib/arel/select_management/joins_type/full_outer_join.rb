class FullOuterJoin

    attr_accessor :type

    def initialize
        @type = " FULL OUTER JOIN "
    end

    def get_result_string
        self.type
    end

end