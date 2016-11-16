require "razor_product_info/version"

require "razor_product_info/errors"
require "razor_product_info/client"

require "razor_product_info/base_model"
require "razor_product_info/product_info"

module RazorProductInfo

  DEFAULT_CONFIG = Hashie::Mash.new({
    base_url: "https://razor-product-info.herokuapp.com/api/v1/",
    auth_token: nil,
  })


  def self.config
    @@config
  end
  def self.reset_config!
    @@config = DEFAULT_CONFIG
  end
  reset_config!


  def self.global_client
    @@global_client ||= Client.new
  end
  def self.reset_global_client!
    @@global_client = nil
  end

end
