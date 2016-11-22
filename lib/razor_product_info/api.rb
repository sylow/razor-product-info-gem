require 'razor_product_info/token_authentication'
require 'razor_product_info/error_handler'
require 'faraday_middleware'

module RazorProductInfo

  Api = Her::API.new

  def self.setup_api!
    Api.setup url: "#{RazorProductInfo.config.host}/api/v#{RazorProductInfo.config.version}/" do |c|
      # Request
      c.use RazorProductInfo::TokenAuthentication
      c.use FaradayMiddleware::EncodeJson

      # Response
      c.use Her::Middleware::DefaultParseJSON
      c.use RazorProductInfo::ErrorHandler

      # Adapter
      c.use Faraday::Adapter::NetHttp
    end
  end

end
