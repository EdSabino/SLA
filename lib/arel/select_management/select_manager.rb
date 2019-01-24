require_relative "require_select.rb"
require_relative "../../../database/accesser.rb"
require_relative "../../../database/db_config.rb"
# require_relative "db_types/require_db_type.rb"
require_relative "visitor.rb"


class SelectManager
    attr_accessor :froms, :selects, :wheres, :joins, :raw_result, :results, :limit, :groups

    def initialize()
        @selects = []
        @wheres = []
        @joins = []
        @groups = []
    end

    def from(expression)
        self.froms = From.new(expression)
        self
    end

    def select(expression)
        self.selects << Select.new(expression)
        self
    end

    def where(expression)
        self.wheres << Where.new(expression)
        self
    end

    def join(destiny, condition)
        self.joins << Joins.new(destiny, condition)
        self
    end

    def limit_to(number)
        self.limit = Limit.new(number)
    end

    def get_results_obj
        self.raw_result = Accesser.new().connect_to_db(self.to_sql)
        turn_to_object
    end

    def get_results_hash
        self.raw_result = Accesser.new().connect_to_db(self.to_sql)
        turn_to_hash
    end

    def to_sql
        return Visitor.visit(DbConfig.new.type_db.to_s, self)
    end

    private

    def turn_to_object
        self.results = []
        self.raw_result.each do |hash|
            obj = Object.new()
            hash.each do |key, value|
                obj.class.module_eval {attr_accessor key.to_sym}
                obj.send("#{key}=", value) 
            end
            self.results << obj
        end
        self.results
    end

    def turn_to_hash
        self.results = []
        self.raw_result.each do |hash|
            self.results << hash
        end
        self.results
    end

end