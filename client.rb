require './_requirements.rb'

module ApiClient
  API_HOST = '0.0.0.0'
  API_PORT = '3000'
  API_ID   = 'test'
  API_KEY  = 'test'
  API_VERSION = '1'
  DEBUG_REQUESTS = false
  DEBUG_RESPONSES = false

  class Base
    class << self
      attr_accessor :endpoint_name
    end

    #get items collection from specified link endpoint
    def self.list_by_url(url)
      request(url, 'GET')
    end

    #get single item data from specified link endpoint
    def self.retreive_by_url(url)
      request(url, 'GET')
    end

    #get single item data by its id
    def self.retreive_by_id(id)
      url = "/api/#{endpoint_name}/#{id}"
      request(url, 'GET')
    end

    #create item (data hash and parent {key: value})
    def self.create(data, parent)
      url = form_request_url(data, parent)

      formed_data = form_request_body(data)
      request(url, 'POST', formed_data)
    end

    private

    def self.request(url, method, payload = nil)
      http = Net::HTTP.new(API_HOST, API_PORT)
      headers = {
        'Accept'        => "application/json; version=#{API_VERSION}",
        'Authorization' => "Basic #{Base64.encode64("#{API_ID}:#{API_KEY}")}",
        'Content-Type'  => "application/json"
      }

      response = http.send_request(method, "/api/#{url}", payload, headers)
      parsed_response = JSON::Api::Vanilla.parse(response.body)

      #some optional debugging
      puts [method, url, payload, headers].inspect if DEBUG_REQUESTS
      puts response.body.inspect if DEBUG_RESPONSES
      puts " " if DEBUG_REQUESTS || DEBUG_RESPONSES

      parsed_response
    end

    def self.form_request_url(data, parent)
      parent_resource = parent.keys.first
      parent_resource_id = parent.values.first
      "/#{parent_resource}/#{parent_resource_id}/#{self.endpoint_name}"
    end

    def self.form_request_body(data)
      {
        data: {
          type: self.endpoint_name,
          attributes: data
        }
      }.to_json
    end
  end


  class Branch < Base
    self.endpoint_name = 'branches'
  end

  class Landlord < Base
    self.endpoint_name = 'landlords'
  end

  class Property < Base
    self.endpoint_name = 'properties'
  end

end
