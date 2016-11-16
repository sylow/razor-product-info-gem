require "razor_product_info/version"

require "razor_product_info/errors"
require "razor_product_info/client"

module RazorProductInfo
  @@config = Hashie::Mash.new({
    base_url: "https://razor-product-info.herokuapp.com/api/v1/",
    auth_token: nil,
  })

  def self.config
    @@config
  end

  def self.global_client
    @@global_client ||= Client.new
  end

end
