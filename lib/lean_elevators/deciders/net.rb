require 'net/http'
require 'json'

module LeanElevators
  module Deciders
    class Net
      def initialize(uri)
        @uri = URI.parse(uri)
        @connection = ::Net::HTTP.new(@uri.host, @uri.port).tap do |http|
          http.use_ssl = @uri.scheme == 'https'
        end.start # Start here to reuse connection
      end

      def calculate_level(decider_dto)
        response = @connection.request(build_json_post(decider_dto))
        JSON.parse(response.body).to_i
      end

      private

      def build_json_post(decider_dto)
        request = ::Net::HTTP::Post.new(@uri, 'Content-Type' => 'application/json')
        request.body = decider_dto.to_hash.to_json
        request
      end
    end
  end
end
