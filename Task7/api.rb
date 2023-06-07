# frozen_string_literal: true

require 'net/http'

class Api
  def self.send_request
    10.times do |i|
      response = Net::HTTP.get_response(URI(request_url))
      if response.code == '200'
        puts "Request successful!"
        return response
      end

      puts "Attempt ##{i + 1}: Received #{response.code} error"
    end

    puts "Maximum retries reached. Request unsuccessful."
  end

  def self.request_url
    status = [200, 500].sample
    dummy_endpoint = "https://httpbin.org/status/#{status}"
  end
end

Api.send_request
