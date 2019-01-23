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
            params: get_params(params),
            method: method,
            headers: parse_headers
        }
    end

    private

    def parse_headers
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

    def get_params(params)
        return [] unless params
        URI::decode_www_form(params).to_h.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    end
end