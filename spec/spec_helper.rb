$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'razor_product_info'
require 'ostruct'
require 'awesome_print'
require 'pry'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)


RSpec.configure do |config|

  config.before(:each) do
    RazorProductInfo.configure do |c|
      c.host = "https://example.com"
      c.version = 1
      c.auth_token = nil

      c.cache_refresh_interval = nil
    end
  end

end
