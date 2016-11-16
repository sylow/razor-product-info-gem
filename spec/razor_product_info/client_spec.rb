require 'spec_helper'

RSpec.describe RazorProductInfo::Client do

  let(:client) { RazorProductInfo::Client.new(auth_token: auth_token, base_url: base_url) }
  let(:base_url) { "https://razor-product-info.herokuapp.com/api/v1/" }
  let(:auth_token) { nil }

  let(:response_status) { 200 }
  let(:response_body) { "" }

  before do
    stub_request(:get, "#{base_url}the_endpoint").
      to_return(status: response_status, body: response_body, headers: {})
  end

  it "responds to http request methods" do
    expect(client).to respond_to(:get)
    expect(client).to respond_to(:post)
    expect(client).to respond_to(:patch)
    expect(client).to respond_to(:delete)
    expect(client).not_to respond_to(:any_arbitrary_method)
  end

  context "with auth token" do
    let(:auth_token) { "abc" }

    it "sends a correct authorization header" do
      client.get("the_endpoint")
      expect(
        a_request(:get, "#{base_url}the_endpoint",).
          with(headers: {'Authorization' => "Token token=abc"})
      ).to have_been_made.once
    end
  end

  context "when receiving a body" do
    let(:response_body) { '{"test": "value"}' }

    it "Hashie::Mash-es the response" do
      resp = client.get("the_endpoint")
      expect(resp.test).to eq('value')
    end
  end

  context "when request wasn't successful" do
    let(:response_status) { 422 }
    let(:response_body) { '{"error": "test error"}' }

    it "raises an error" do
      expect { client.get("the_endpoint") }.
        to raise_error(RazorProductInfo::Error).with_message("test error")
    end
  end

end
