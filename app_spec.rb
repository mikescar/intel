require "pry"
require "rspec"
require "functions_framework/testing"

describe "functions_server_headers_get" do
  include FunctionsFramework::Testing

  it "returns error response code" do
    load_temporary "app.rb" do
      request = make_get_request "http://example.com:8080/"
      response = call_http "server_headers", request

      expect(response.status).to eq 200

      body = JSON.parse(response.body.first)

      expect(body["response_code"]).to eq 500
      # expect(response.body.join).to eq "Hello Ruby!\n"
    end
  end
end