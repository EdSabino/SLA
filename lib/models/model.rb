require_relative "../arel/require_arel.rb"
require_relative "../utils/extend_string.rb"

class Model
    @@belongs_to_att = {}
    @@has_manys_att = {}
    @@model_attributes = []

    def self.table_name
        @@table_name
    end

    def self.model_attributes(*atts)
        @@model_attributes = atts
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

    self.get_model_attributes.each do |att|
        define_method("find_by_#{att}") do |val|
            self.find_by(att, val)
        end
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
        table = Table.new(self.table_name)
        table.where(table.attr(att).eq(val.to_s)).get_results_obj(self.new())
    end

end