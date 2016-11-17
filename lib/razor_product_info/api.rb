require 'razor_product_info/token_authentication'

module RazorProductInfo

  Api = Her::API.new
  puts RazorProductInfo.config.base_url
  Api.setup url: RazorProductInfo.config.base_url do |c|
    # Request
    c.use RazorProductInfo::TokenAuthentication

    # Response
    c.use Her::Middleware::DefaultParseJSON

    # Adapter
    c.use Faraday::Adapter::NetHttp
  end

end
