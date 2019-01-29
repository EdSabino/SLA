module AcceptInsertMethods

    def accept_attributes(obj_attributes)
        obj_attributes.attrs.map { |att| att.get_result_string }.join(", ")
    end

    def accept_values(obj_values)
        obj_values.values.map { |val| val.get_result_string }.join(", ")
    end

end