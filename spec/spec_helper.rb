$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'razor_product_info'
require 'ostruct'
require 'awesome_print'
require 'pry'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)
