require 'net/http'

def send_post_request
  max_retries = 10
  retries = 0
  data = { "key" => "value" }

  while retries < max_retries
    response = Net::HTTP.post_form(URI(request_url), data)
    if response.code == '200'
      return response
    end

    puts "Attempt ##{retries + 1}: Received #{response.code} error"
    retries += 1
  end

  response
end

def request_url
  status = [200, 500].sample
  dummy_endpoint = "https://httpbin.org/status/#{status}"
end

response = send_post_request

if response.code == '200'
  puts "Request successful!"
else
  puts "Maximum retries reached. Request unsuccessful."
end
