require './_requirements.rb'

module ApiClient
  API_HOST = '0.0.0.0'
  API_PORT = '3000'
  API_ID   = 'test'
  API_KEY  = 'test'
  API_VERSION = '1'

  class Base
    class << self
      attr_accessor :list_url
    end

    #get items collection from specified link endpoint
    def self.list_by_url(url = self.list_url)
      request(url, 'GET')
    end

    #get single item data from specified link endpoint
    def self.retreive_by_url(url)
      request(url, 'GET')
    end

    private

    def self.request(url, method, payload = nil)
      http = Net::HTTP.new(API_HOST, API_PORT)
      headers = {
        'Accept'        => "application/json; version=#{API_VERSION}",
        'Authorization' => "Basic #{Base64.encode64("#{API_ID}:#{API_KEY}")}"
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
