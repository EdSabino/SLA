require_relative "require_select.rb"
require_relative "../../../database/accesser.rb"
require_relative "../../../database/db_config.rb"
# require_relative "db_types/require_db_type.rb"
require_relative "../visitor.rb"


class SelectManager
    attr_accessor :froms, :selects, :wheres, :joins, :raw_result, :results, :limit, :groups, :class_name, :includes

    def initialize(class_name=nil)
        @selects = []
        @wheres = []
        @joins = []
        @groups = []
        @includes = {}
        @class_name = class_name if class_name
    end

    def include_relation(hash)
        self.includes[hash.keys.first] = hash.values.first
        self
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
    
    def get_result_string
        return " ( " + self.to_sql + " ) "
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
        includes_results = []
        self.includes.each do |key, value|
            next unless self.class_name.has_manys_att[value]
            relation = self.class_name.has_manys_att[value]
            binding.pry

            includes_results << SelectManager.new.from(Table.new(Object.const_get(relation[:class_name]).table_name)).join(Table.new(self.class_name.table_name), Table.new(self.class_name.table_name).attr(:id).eq(Table.new(Object.const_get(relation[:class_name]).table_name).attr(relation[:foreign_key]))).get_results_hash
        end
        binding.pry
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