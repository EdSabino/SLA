require_relative "../controller.rb"
require_relative "../require_controllers.rb"
require_relative "routes.rb"
SERVER_HOST = "views/"

class Response

    attr_accessor :request, :response, :code, :routes, :path
    
    def initialize(*opts)
        opts = opts.first
        @request = opts[:request]
        @routes = opts[:routes]
    end

    def prepare_response
        self.path = get_path
        respond_with
    end

    def send(client)
        client.write(self.response)
    end

    private

    def respond_with
        File.exists?("views#{self.path.url_path}.html.erb") ? send_ok_response : send_file_not_found
    end

    def send_ok_response
        self.code = 200
        controller, method = self.path.controller_route.split("#")
        set_response(Object.const_get("#{controller.capitalize}Controller").new("views#{self.path.url_path}.html.erb", method, request[:params]).send(method))
    end

    def send_file_not_found
        self.code = 404
        set_response
    end

    def set_response(data="")
        self.response = 
        "HTTP/1.1 #{self.code}\r\n" +
        "Content-Length: #{data.size}\r\n" +
        "\r\n" +
        "#{data}\r\n"
    end

    def get_path
        return self.routes.root if self.request[:path] == "/"
        get_route
    end
    
    def get_route
        path = self.request[:path].gsub("/", "_")
        path[0] = ''
        routes.send("#{path}")
    end
end