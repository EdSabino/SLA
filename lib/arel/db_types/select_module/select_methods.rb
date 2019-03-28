module SelectMethods

    def resolve_select_sql
        str = "SELECT "
        str += get_selects
        str += " FROM "
        str += get_from
        str += get_joins if self.subject.joins.any?
        str += " WHERE (" + get_where + ")" if self.subject.wheres.any? 
        str += " LIMIT " + get_limit if self.subject.limit
        str += " GROUP BY " + get_group if self.subject.groups.any?
        puts str
        return str
    end

    private

    def get_table
        self.subject.table.get_result_string
    end
    
    def get_selects
        return "*" unless self.subject.selects.any?
        return self.subject.selects.map { |select| select.get_result_string }.join(", ")
    end

    def get_from
        self.subject.froms.get_result_string
    end

    def get_where
        return self.subject.wheres.map { |where| where.get_result_string }.join(") AND (")
    end

    def get_joins
        return self.subject.joins.map { |sjoin| sjoin.get_result_string }.join(" ")
    end

    def get_limit
        self.subject.limit.get_result_string
    end

    def get_group
        self.subject.groups.map { |grp| grp.get_result_string }.join(", ")
    end

end