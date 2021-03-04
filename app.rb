require "functions_framework"
require "httparty"
require "json"

# This function receives an HTTP request of type Rack::Request
# and interprets the body as JSON. It prints the contents of
# the "message" field, or "Hello World!" if there isn't one.
FunctionsFramework.http "server_headers" do |request|
  input = JSON.parse request.body.read rescue {}

  begin
    domain = input["domain"].to_s

    response = HTTParty.get(domain)

    {
      "response_code": response.code,
      "response_headers": response.headers
    }
  rescue Exception => e
    {
      "response_code": 500,
      "error": e.message
    }
  end
end
