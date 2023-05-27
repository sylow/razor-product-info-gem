# -*- encoding: utf-8 -*-
# stub: razor_product_info 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "razor_product_info".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Max Hollmann".freeze]
  s.bindir = "exe".freeze
  s.date = "2022-06-01"
  s.email = ["max.hollmann@toptal.com".freeze]
  s.files = [".gitignore".freeze, ".pryrc".freeze, ".rspec".freeze, ".ruby-version".freeze, ".travis.yml".freeze, "Gemfile".freeze, "Guardfile".freeze, "README.md".freeze, "Rakefile".freeze, "bin/console".freeze, "bin/setup".freeze, "lib/razor_product_info.rb".freeze, "lib/razor_product_info/api.rb".freeze, "lib/razor_product_info/base_model.rb".freeze, "lib/razor_product_info/error_handler.rb".freeze, "lib/razor_product_info/errors.rb".freeze, "lib/razor_product_info/product_info.rb".freeze, "lib/razor_product_info/refresh_thread.rb".freeze, "lib/razor_product_info/token_authentication.rb".freeze, "lib/razor_product_info/version.rb".freeze, "razor_product_info.gemspec".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Client library for Razor product info service.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.12"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_development_dependency(%q<awesome_print>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<guard-rspec>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<her>.freeze, ["= 0.8.1"])
    s.add_runtime_dependency(%q<faraday_middleware>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<concurrent-ruby>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.12"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<awesome_print>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<guard-rspec>.freeze, [">= 0"])
    s.add_dependency(%q<her>.freeze, ["= 0.8.1"])
    s.add_dependency(%q<faraday_middleware>.freeze, [">= 0"])
    s.add_dependency(%q<concurrent-ruby>.freeze, [">= 0"])
  end
end
