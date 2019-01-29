require_relative "../../../database/accesser.rb"
require_relative "../../../database/db_config.rb"
require_relative "../visitor.rb"
require_relative "../select_management/table.rb"
require_relative "../sql_literal.rb"
require_relative "attributes.rb"
require_relative "values.rb"

class InsertManager

    attr_accessor :attributes, :values, :table

    def initialize(args, table)
        @attributes = Attributes.new(args.keys)
        @values = Values.new(args.values)
        @table = Table.new(table)
    end

    def insert_into_db
        Accesser.new().connect_to_db(self.to_sql)
    end

    def to_sql
        return Visitor.visit(DbConfig.new.type_db.to_s, "insert_sql", self)
    end

end