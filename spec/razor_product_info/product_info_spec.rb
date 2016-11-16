require 'spec_helper'

RSpec.describe RazorProductInfo::ProductInfo do

  let(:client) { RazorProductInfo::Client.new(auth_token: auth_token, base_url: base_url) }
  let(:base_url) { "https://razor-product-info.herokuapp.com/api/v1/" }
  let(:auth_token) { nil }

  let(:response_status) { 200 }
  let(:response_body) { "" }

  describe ".all" do
    before do
      stub_request(:get, "#{base_url}product_infos").
        to_return(status: response_status, body: response_body, headers: {})
    end

    let(:response_body) {
      [
        {id: 1, name: "Test product"},
      ]
    }

    it "calls /product_infos" do
      RazorProductInfo::ProductInfo.all
      expect(a_request(:get, "#{base_url}product_infos"))
    end

    it "returns all ProductInfos" do
      info = RazorProductInfo::ProductInfo.all.first
      expect(info.name).to eq("Test product")
      expect(info.id).to eq(1)
    end
  end

  describe ".find" do
    before do
      stub_request(:get, "#{base_url}product_infos/1").
        to_return(status: response_status, body: response_body, headers: {})
    end

    let(:response_body) {
      JSON.dump({id: 1, name: "Test product"})
    }

    it "calls /product_infos/1" do
      RazorProductInfo::ProductInfo.find(1)
      expect(a_request(:get, "#{base_url}product_infos/1"))
    end

    it "returns all ProductInfos" do
      info = RazorProductInfo::ProductInfo.find(1)
      expect(info.name).to eq("Test product")
      expect(info.id).to eq(1)
    end
  end

end
