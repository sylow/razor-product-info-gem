require 'spec_helper'

RSpec.describe RazorProductInfo::ProductInfo do

  before(:each) { RazorProductInfo::ProductInfo.reset_cache! }

  let(:response_status) { 200 }
  let(:response_body) { "" }

  describe ".all" do
    before do
      stub_request(:get, "https://example.com/api/v1/product_info").
        to_return(status: response_status, body: response_body, headers: {})
    end

    let(:response_body) { JSON.dump(
      [
        {id: 1, description: "Test product"},
      ]
    ) }

    it "calls /product_info" do
      RazorProductInfo::ProductInfo.all
      expect(a_request(:get, "https://example.com/api/v1/product_info"))
    end

    it "returns all ProductInfos" do
      info = RazorProductInfo::ProductInfo.all.first
      expect(info.description).to eq("Test product")
      expect(info.id).to eq(1)
    end
  end

  describe ".find" do
    before do
      stub_request(:get, "https://example.com/api/v1/product_info/1").
        to_return(status: response_status, body: response_body, headers: {})
    end

    let(:response_body) {
      JSON.dump({id: 1, description: "Test product"})
    }

    it "calls /product_info/1" do
      RazorProductInfo::ProductInfo.find(1)
      expect(a_request(:get, "https://example.com/api/v1/product_info/1"))
    end

    it "returns all ProductInfos" do
      info = RazorProductInfo::ProductInfo.find(1)
      expect(info.description).to eq("Test product")
      expect(info.id).to eq(1)
    end
  end

  describe ".find_by_(sku|upc)" do
    before do
      stub_request(:get, "https://example.com/api/v1/product_info").
        to_return(status: response_status, body: response_body, headers: {})
    end

    let(:response_body) { JSON.dump(
      [
        {id: 1, sku: "SKU1", description: "Test product1"},
        {id: 2, sku: "SKU2", upc: "UPC2", description: "Test product2"},
      ]
    ) }

    it "requests all products on the first call, then uses its cache" do
      RazorProductInfo::ProductInfo.find_by_sku("sku1")
      RazorProductInfo::ProductInfo.find_by_sku("sku2")
      RazorProductInfo::ProductInfo.find_by_upc("upc2")
      RazorProductInfo::ProductInfo.find_by_upc("upc2")
      expect(a_request(:get, "https://example.com/api/v1/product_info")).to have_been_made.once
    end

    it "returns the correct ProductInfo by case insensitive SKU" do
      expect(RazorProductInfo::ProductInfo.find_by_sku("Sku2").attributes).to match(
        a_hash_including(
          sku: "SKU2", description: "Test product2"
        )
      )
    end

    it "returns the correct ProductInfo by case insensitive UPC" do
      expect(RazorProductInfo::ProductInfo.find_by_upc("Upc2").attributes).to match(
        a_hash_including(
          upc: "UPC2", description: "Test product2"
        )
      )
    end

    it "returns the correct ProductInfo by UPC with leading zeroes" do
      expect(RazorProductInfo::ProductInfo.find_by_upc("00Upc2").attributes).to match(
        a_hash_including(
          upc: "UPC2", description: "Test product2"
        )
      )
    end


    describe ".reset_cache!" do
      it "updates the cache" do
        RazorProductInfo::ProductInfo.find_by_upc("upc2")
        RazorProductInfo::ProductInfo.reset_cache!
        RazorProductInfo::ProductInfo.find_by_upc("upc2")
        expect(a_request(:get, "https://example.com/api/v1/product_info")).to have_been_made.twice
      end
    end
  end


end
