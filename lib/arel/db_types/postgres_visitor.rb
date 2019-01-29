require_relative "postgres_adapter.rb"
require_relative "default_db_visitor.rb"

class PostgresVisitor < DefaultDbVisitor

    def accept_select_sql(object)
        PostgresAdapter.new(object).resolve_select_sql
    end

    def accept_insert_sql(object)
        PostgresAdapter.new(object).resolve_insert_sql
    end
end