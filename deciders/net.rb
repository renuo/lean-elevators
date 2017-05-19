require 'net/http'

module Deciders
  class Net
    def initialize
      @uri = URI.parse('https://127.0.0.1:3001/decider')
      @http = ::Net::HTTP.new(@uri.host, @uri.port).start # Start here to reuse connection
    end

    def calculate_level(decider_dto)
      response = @http.request(build_json_post(decider_dto))
      response.body.to_i
    end

    private

    def build_json_post(decider_dto)
      request = ::Net::HTTP::Post.new(@uri, 'Content-Type' => 'application/json')
      request.body = decider_dto.to_json
      request
    end
  end
end
