class DefaultDbVisitor

    def accept_case(obj_case)
        str = " CASE " + obj_case.whens.map {|when_obj| when_obj.get_result_string}.join(" ")
        str += " ELSE " + obj_case.else_result.get_result_string if obj_case.else_result
        str += " END "
        return str
    end

    def accept_when(obj_when)
        " WHEN " + obj_when.expression.get_result_string + " THEN " + obj_when.result.get_result_string
    end

    def accept_sqlliteral(obj_sql)
        obj_sql.expression
    end

    def accept_leftjoin(left_join_obj)
        " LEFT JOIN "
    end

    def accept_innerjoin(inner_join_obj)
        " INNER JOIN "
    end

    def accept_fullouterjoin(full_outer_join_obj)
        " FULL OUTER JOIN "
    end

    def accept_attribute(obj_attr)
        return obj_attr.table.get_result_string + "." + obj_attr.name
    end

    def accept_condition(obj_condition)
        return obj_condition.left.get_result_string unless obj_condition.right
        return obj_condition.left.get_result_string + obj_condition.concatenator + "(#{obj_condition.right.get_result_string})"
    end

    def accept_from(obj_from)
        return obj_from.expression.get_result_string
    end

    def accept_group(obj_group)
        return obj_group.attribute.get_result_string
    end

    def accept_joins(obj_joins)
        return " #{obj_joins.type.get_result_string} " + obj_joins.destiny.get_result_string + " ON " + obj_joins.condition.get_result_string
    end

    def accept_limit(obj_limit)
        return obj_limit.number
    end

    def accept_operators(obj_operator)
        return obj_operator.left.get_result_string + " " +  obj_operator.operator + " " + "(#{obj_operator.right.get_result_string})"
    end

    def accept_select(obj_select)
        return obj_select.expression.get_result_string
    end

    def accept_table(obj_table)
        return obj_table.name
    end

    def accept_where(obj_where)
        return obj_where.expression.get_result_string
    end

end