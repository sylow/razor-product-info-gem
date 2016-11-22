#require 'pry'
#require 'awesome_print'

require 'her'
require 'ostruct'

require "razor_product_info/version"
require "razor_product_info/errors"

require "razor_product_info/api"
require "razor_product_info/base_model"
require "razor_product_info/product_info"

module RazorProductInfo

  DEFAULT_CONFIG = OpenStruct.new(
    host: "https://razor-product-info.herokuapp.com",
    version: 1,
    auth_token: nil,
  )


  def self.configure
    yield @@config
    setup_api!
  end

  private

    def self.config
      @@config
    end
    def self.reset_config!
      @@config = DEFAULT_CONFIG
    end
    reset_config!


end
