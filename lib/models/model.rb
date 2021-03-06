require_relative "../arel/require_arel.rb"
require_relative "../utils/extend_string.rb"

class Model
    @@belongs_to_att = {}
    @@has_manys_att = {}
    @@model_attributes = []
    @@validations = []

    def initialize(args=nil)
        @errors = []
        return self unless args
        args.each do |key, value|
            self.send("#{key}=", value)
        end
        return self
    end

    def self.table_name
        @@table_name
    end

    def self.model_attributes(*atts)
        @@model_attributes = atts
        atts.each do |att|
            self.module_eval {attr_accessor att}
            define_singleton_method("find_by_#{att}") do |val|
                self.find_by(att, val)
            end
        end
    end

    def errors
        @errors
    end

    def errors=(val)
        @errors << val
    end

    def self.validations
        @@validations
    end

    def self.get_model_attributes
        @@model_attributes
    end

    def self.table_name=(val)
        @@table_name = val
    end

    def self.has_manys_att
        @@has_manys_att
    end

    def self.belongs_to_att
        @@belongs_to_att
    end

    def self.validates(type, *opts)
        @@validations << Object.const_get("Validate#{type.capitalize.constantize}").new(opts) 
    end

    def self.has_many(relation, opts)
        self.has_manys_att[relation] = {}
        self.has_manys_att[relation][:class_name] = opts[:class_name] ? opts[:class_name] : relation.to_s.singularize.camelize
        self.has_manys_att[relation][:foreign_key] = opts[:foreign_key] ? opts[:foreign_key] : relation.to_s.singularize.chomp("_id").to_sym
        create_method(relation) do
            recover_has_many(__method__)
        end
    end

    def self.belongs_to(relation, opts)
        self.belongs_to_att[relation] = {}
        self.belongs_to_att[relation][:class_name] = opts[:class_name] ? opts[:class_name] : relation.to_s.camelize
        self.belongs_to_att[relation][:foreign_key] = opts[:foreign_key] ? opts[:foreign_key] : relation.to_s.chomp("_id").to_sym
        create_method(relation) do
            recover_belong(__method__)
        end
    end

    def get_attributes
        self.class.get_model_attributes
    end

    def self.create(args)
        self.new(args).save
    end

    def self.scoped
        SelectManager.new(self).from(Table.new(self.table_name))
    end

    def self.joins(expression)
        scoped.join(expression)
    end

    def self.where(expression)
        scoped.where(expression)
    end

    def self.select(expression)
        scoped.select(expression)
    end

    def self.all
        scoped.get_results_obj
    end

    def save
        validate
        hash = {}
        self.get_attributes.each do |att|
            hash[att] = self.send("#{att}")
        end
        InsertManager.new(hash, self.table_name).insert_into_db
    end

    private

    def recover_belong(method)
        tb = Table.new(self.class.table_name)
        related_table = Table.new(Object.const_get(self.belongs_to_att[method][:class_name]).class.table_name)
        return related_table.select(related_table.attr("*")).join(tb, tb.attr(self.belongs_to_att[__method__][:class_name]).eq(related_table.attr(:id))).get_results_obj.first
    end

    def recover_has_many(method)
        tb = Table.new(self.table_name)
        related_table = Table.new(Object.const_get(self.has_manys_att[method][:class_name]).class.table_name)
        return related_table.select(related_table.attr("*")).join(tb, related_table.attr(self.has_manys_att[__method__][:foreign_key]).eq(tb.attr(:id))).where(tb.attr(:id).eq(self.id)).get_results_obj
    end

    def self.create_method(name, &block)
        self.send(:define_singleton_method, name, &block)
    end

    def self.find_by(att, val)
        scoped.where(table.attr(att).eq(val.to_s)).get_results_obj(self)[0]
    end

    def validate
        self.class.validations.each do |validator|
            validator.validate()
        end
    end

end