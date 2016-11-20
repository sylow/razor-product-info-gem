# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'razor_product_info/version'

Gem::Specification.new do |spec|
  spec.name          = "razor_product_info"
  spec.version       = RazorProductInfo::VERSION::STRING
  spec.authors       = ["Max Hollmann"]
  spec.email         = ["max.hollmann@toptal.com"]

  spec.summary       = %q{Client library for Razor product info service.}

  spec.files         = `git ls-files -z`.split("\x0").reject { |f|
    f.match(%r{^(test|spec|features|examples)/})
  }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "pry"

  # TODO figure out minimum version requirements
  spec.add_dependency "her", "0.8.1"
  spec.add_dependency "faraday_middleware"
end
