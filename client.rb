require 'base64'
require 'net/http'
require "json-api-vanilla"

require 'rubygems'
require 'bundler/setup'
Bundler.require

module ApiClient

  class Base
    class << self
      attr_accessor :list_url
    end

    def self.list_by_url(url = self.list_url)
      request(url, 'GET')
    end

    def self.retreive_by_url(url)
      request(url, 'GET')
    end

    private

    def self.request(url, method, payload = nil)
      http = Net::HTTP.new('0.0.0.0', '3000')
      headers = {
        'Accept'        => 'application/json; version=1',
        'Authorization' => "Basic #{Base64.encode64('test:test')}"
      }

      response = http.send_request(method, url, payload, headers)
      JSON::Api::Vanilla.parse(response.body)
    end
  end

  class Branch < Base
    self.list_url = '/api/branches'
  end

  class Landlord < Base
  end

  class Property < Base
  end

end

doc = ApiClient::Branch.list_by_url
puts doc.data[0].name.inspect