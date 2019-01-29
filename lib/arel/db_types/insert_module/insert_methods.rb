module InsertMethods

    def resolve_insert_sql
        str = "INSERT INTO "
        str += get_table
        str += " ( " + get_attributes + " ) "
        str += " VALUES (" + get_values + " ); "
    end

    private

    def get_attributes
        self.subject.attributes.get_result_string
    end

    def get_values
        self.subject.values.get_result_string
    end
end