# TODO only require in development
require 'pry'
require 'awesome_print'

require 'her'
require 'ostruct'

require "razor_product_info/version"

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

end

require "razor_product_info/api"
require "razor_product_info/base_model"
require "razor_product_info/product_info"
