module RazorProductInfo

  class ProductInfo < BaseModel

    def self.all
      client.get("product_infos").map {|r| ProductInfo.new(r) }
    end

    def self.find(id)
      ProductInfo.new(client.get("product_infos/#{id}"))
    end

  end

end
