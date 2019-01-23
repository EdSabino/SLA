require_relative "select.rb"
require_relative "from.rb"
require_relative "arel_table.rb"
require_relative "../../database/accesser.rb"

class SelectManager
    attr_accessor :froms, :selects, :wheres, :joins, :raw_result, :results

    def initialize()
        @selects = []
        @wheres = []
        @joins = []
    end

    def from(expression)
        self.froms = From.new(expression)
        self
    end

    def build_sql
        str = "SELECT "
        str += get_selects
        str += " FROM "
        str += get_from
        str += " WHERE (" + get_where + ")"
    end

    def select(expression)
        self.selects << Select.new(expression)
        self
    end

    def where(expression)
        self.wheres << Where.new(expression)
    end

    def get_results_obj
        self.raw_result = Accesser.new().connect_to_db(self.build_sql)
        turn_to_object
    end

    def get_results_hash
        self.raw_result = Accesser.new().connect_to_db(self.build_sql)
        turn_to_hash
    end

    private

    def get_selects
        return "*" unless self.selects.any?
        return self.selects.map { |select| select.get_result_string }.join(", ")
    end

    def get_from
        self.froms.get_result_string
    end

    def get_where
        return self.wheres.map { |where| where.get_result_string }.join(") AND (")
    end

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
    end

    def turn_to_hash
        self.results = []
        self.raw_result.each do |hash|
            self.results << hash
        end
    end

end