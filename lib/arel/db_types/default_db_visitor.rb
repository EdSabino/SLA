require_relative "select_module/accept_select_methods.rb"
require_relative "insert_module/accept_insert_methods.rb"

class DefaultDbVisitor
    include AcceptSelectMethods
    include AcceptInsertMethods

    def accept_sqlliteral(obj_sql)
        obj_sql.expression
    end

end