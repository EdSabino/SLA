require_relative "postgres_adapter.rb"
require_relative "default_db_visitor.rb"

class PostgresVisitor < DefaultDbVisitor

    def accept_sql(object)
        PostgresAdapter.new(object).resolve_sql
    end
end