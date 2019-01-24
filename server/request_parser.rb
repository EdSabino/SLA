require "pry"
require 'cgi'
class Parser

    attr_accessor :request, :parsed_request, :code

    def initialize(*request)
        request = request.first
        @request = request[:request]
        self
    end

    def parse
        method, path, version = self.request.lines[0].split
        path, params = path.split("?")
        self.parsed_request = {
            path: path,
            headers: parse_headers(method),
            params: get_params(params, method),
            method: method
        }
    end

    private

    def parse_headers(method)
        headers = {}

        request.lines[1..-1].each do |line|
            return headers if line == "\r\n"
            header, value = line.split
            header = normalize_header(header)
            headers[header] = value
        end
    end

    def normalize_header(header)
        header.gsub(":", "").downcase.to_sym
    end

    def get_params(params, method)
        if method == "POST"
            begin
                JSON.parse(self.request.lines[1..-1][self.request.lines[1..-1].index("\r\n")+1..-1].join)
            rescue
                []
            end
        else
            return [] unless params
            URI::decode_www_form(params).to_h
        end
    end
end