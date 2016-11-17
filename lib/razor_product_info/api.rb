require 'razor_product_info/token_authentication'
require 'faraday_middleware'

module RazorProductInfo

  Api = Her::API.new
  Api.setup url: "#{RazorProductInfo.config.host}/api/v#{RazorProductInfo.config.version}/" do |c|
    # Request
    c.use RazorProductInfo::TokenAuthentication
    c.use FaradayMiddleware::EncodeJson

    # Response
    c.use Her::Middleware::DefaultParseJSON

    # Adapter
    c.use Faraday::Adapter::NetHttp
  end

end
