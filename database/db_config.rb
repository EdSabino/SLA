class DbConfig
    attr_accessor :db_name, :user, :password, :host, :type_db

    def initialize
        @type_db  = :postgres
        @db_name  = "base_t_dev"
        @user     = "postgres"
        @password = "postgres"
        @host     = "localhost"
    end

end