require_relative "postgres_adapter.rb"

class PostgresVisitor

    def accept(object)
        PostgresAdapter.new(object).resolve_sql
    end
end