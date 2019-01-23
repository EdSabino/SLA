class DbConfig
    attr_accessor :db_name, :user, :password, :host

    def initialize
        @db_name  = "base_t_dev"
        @user     = "postgres"
        @password = "postgres"
        @host     = "localhost"
    end

end