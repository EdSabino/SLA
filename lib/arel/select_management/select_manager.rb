require_relative "require_select.rb"
require_relative "../../../database/accesser.rb"
require_relative "../../../database/db_config.rb"
# require_relative "db_types/require_db_type.rb"
require_relative "../visitor.rb"


class SelectManager
    attr_accessor :froms, :selects, :wheres, :joins, :raw_result, :results, :limit, :groups, :class_name

    def initialize(class_name=nil)
        @selects = []
        @wheres = []
        @joins = []
        @groups = []
        @class_name = class_name if class_name
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

    def join(destiny, condition, type=:inner)
        self.joins << Joins.new(destiny, condition, type)
        self
    end

    def limit_to(number)
        self.limit = Limit.new(number)
        self
    end

    def group_by(attribute)
        self.groups << Group.new(attribute)
        self
    end

    def get_results_obj
        self.raw_result = Accesser.new().connect_to_db(self.to_sql)
        self.class_name ? pass_to_object : turn_to_object
    end

    def get_results_hash
        self.raw_result = Accesser.new().connect_to_db(self.to_sql)
        turn_to_hash
    end

    def to_sql
        return Visitor.visit(DbConfig.new.type_db.to_s, "select_sql", self)
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

    def pass_to_object
        self.results = []
        self.raw_result.each do |hash|
            obj = self.class_name.new()
            self.class_name.get_model_attributes.each do |att|
                obj.send("#{att}=", hash[att.to_s])
            end
            self.results << obj
        end
        self.results
    end

end