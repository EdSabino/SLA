require "pg"
require_relative "db_config.rb"
require_relative "../lib/arel/select_management/select_manager.rb"

class Accesser

    attr_accessor :config

    def initialize()
        @config = DbConfig.new()
    end

    def connect_to_db(query)
        connection = PG.connect(dbname: self.config.db_name, host: self.config.host, user: self.config.user, password: self.config.password)
        connection.exec(query)
    end
end