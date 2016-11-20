require 'razor_product_info'

RazorProductInfo.configure do |conf|
  conf.auth_token = ENV['TOKEN']
end
