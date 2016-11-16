require 'spec_helper'

describe RazorProductInfo do
  it 'has a version number' do
    expect(RazorProductInfo::VERSION).not_to be nil
  end

  it "has a global client instance with the default settings" do
    RazorProductInfo.config.auth_token = "123"
    RazorProductInfo.config.base_url = "http://example.com/api"
    c = RazorProductInfo.global_client

    expect(c.class).to eq(RazorProductInfo::Client)
    expect(c.auth_token).to eq("123")
    expect(c.base_url).to eq("http://example.com/api")
  end

end
