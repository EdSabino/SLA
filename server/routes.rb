require_relative "path.rb"
class Routes

    attr_accessor :root, :edit, :index, :base_url

    def initialize(*opts)
        opts = opts.first
        @base_url = opts[:base_url]
        @index = Path.new(controller_route: "start#index", url_path: "/index")
        @edit = Path.new(controller_route: "start#edit", url_path: "/edit")
        @root = @index
    end
end