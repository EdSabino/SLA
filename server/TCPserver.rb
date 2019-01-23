require 'socket'
require "pry"
require_relative "request_parser.rb"
require_relative "response.rb"
require_relative "routes.rb"

PORT = 4000
def handle_connection(connection)
    request = connection.readpartial(2048)
    request  = request = Parser.new(request: request).parse
    routes = Routes.new(base_url: request[:headers][:host])
    response = Response.new(request: request, routes: routes)
    response.prepare_response
    puts "#{connection.peeraddr[3]} #{request.fetch(:path)} - #{response.code}"
    response.send(connection)
    connection.close
end


server = TCPServer.new("localhost", PORT)

puts "Listening on #{PORT}. Press CTRL+C to cancel."

loop do
    connection = server.accept
    Thread.new { handle_connection(connection) }
end

# loop {
#     connection  = server.accept
#     Thread.new { handle_connection(connection) }
# }