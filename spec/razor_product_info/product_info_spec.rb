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


    context "when not authenticated" do
      let(:response_status) { 401 }
      let(:response_body) { '{}' }

      it "raises RazorProductInfo::Unauthorized" do
        expect { RazorProductInfo::ProductInfo.all.first }.to raise_error(RazorProductInfo::Unauthorized)
      end
    end

    context "on server error" do
      let(:response_status) { 500 + rand(100) }

      it "raises RazorProductInfo::ServerError" do
        expect { RazorProductInfo::ProductInfo.all.first }.to raise_error(RazorProductInfo::ServerError)
      end
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

  describe "search methods" do
    before do
      stub_request(:get, "https://example.com/api/v1/product_info").
        to_return(status: response_status, body: response_body, headers: {})
    end

    let(:response_body) { JSON.dump(
      [
        {id: 1, sku: "SKU1", description: "Test product1"},
        {id: 2, sku: "SKU2", upc: "UPC-2", description: "Test product2"},
        {id: 3, sku: "SKU3", upc: "845423018405", description: "Walmart.com product"},
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
          upc: "UPC-2", description: "Test product2"
        )
      )
    end

    it "returns the correct ProductInfo by UPC with leading zeroes" do
      expect(RazorProductInfo::ProductInfo.find_by_upc("00Upc2").attributes).to match(
        a_hash_including(
          upc: "UPC-2", description: "Test product2"
        )
      )
    end

    it "returns the correct ProductInfo by UPC with arbitrary dashes" do
      expect(RazorProductInfo::ProductInfo.find_by_upc("U-p-c2").attributes).to match(
        a_hash_including(
          upc: "UPC-2", description: "Test product2"
        )
      )
    end

    it "returns the correct ProductInfo by UPC from Walmart.com" do
      expect(RazorProductInfo::ProductInfo.find_by_wmcom_upc("0084542301840").attributes).to match(
        a_hash_including(
          upc: "845423018405", description: "Walmart.com product"
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

    describe ".safely_refresh_cache!" do
      def stub_req!(status, body)
        stub_request(:get, "https://example.com/api/v1/product_info").
          to_return(status: status, body: body, headers: {})
      end

      before do
        stub_req!(200, JSON.dump([{id: 1, sku: "SKU1", description: "Test product1"}]))
        RazorProductInfo::ProductInfo.all_cached
      end

      it "leaves old cache intact when API call fails" do
        stub_req!(500, "")
        expect { RazorProductInfo::ProductInfo.safely_refresh_cache! }.
          not_to change(RazorProductInfo::ProductInfo, :all_cached)
      end

      it "yields the error when API call fails" do
        stub_req!(500, "")
        expect { |block| RazorProductInfo::ProductInfo.safely_refresh_cache!(&block) }.
          to yield_with_args(StandardError)
      end

      it "leaves old cache intact when API returns empty result" do
        stub_req!(200, "[]")
        expect { RazorProductInfo::ProductInfo.safely_refresh_cache! }.
          not_to change(RazorProductInfo::ProductInfo, :all_cached)
      end

      it "updates cache when API call succeeds" do
        stub_req!(200, JSON.dump([{id: 1, sku: "SKU1", description: "New desc"}]))
        expect { RazorProductInfo::ProductInfo.safely_refresh_cache! }.
          to change { RazorProductInfo::ProductInfo.all_cached.first.description }.to "New desc"
      end
    end

  end


end
