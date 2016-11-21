# RazorProductInfo

Client library for the Razor product info service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'razor_product_info', git: 'https://dca1bade220658a66ebcbd133fd6978cd0c2b6fb@github.com/27183/razor-product-info-gem.git'
```

And execute:

    $ bundle

You need to create an initializer to configure the API, e.g. `config/initializers/razor_product_info.rb`:

    RazorProductInfo.configure do |conf|
      conf.host       = "https://razor-product-info.herokuapp.com" # default
      conf.version    = 1 # default
      conf.auth_token = ENV['razor_product_info_token']
    end

You can obtain an API token by running

    heroku run rake api:generate_token -a razor-product-info

## Usage

#### `RazorProductInfo::ProductInfo.all`
Returns all products.

#### `RazorProductInfo::ProductInfo.find(id)`
Finds a product by ID (not SKU!).

#### `RazorProductInfo::ProductInfo.find_by_sku(sku)`
#### `RazorProductInfo::ProductInfo.find_by_upc(upc)`
Finds a product by SKU or UPC. The first time one of these methods is called, all products are fetched from the server and cached. To clear the cache, call `RazorProductInfo::ProductInfo.reset_cache!`
