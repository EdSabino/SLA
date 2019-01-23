class Path

    attr_accessor :controller_route, :url_path

    def initialize(*opts)
        opts = opts.first
        @controller_route = opts[:controller_route]
        @url_path = opts[:url_path]
    end
end