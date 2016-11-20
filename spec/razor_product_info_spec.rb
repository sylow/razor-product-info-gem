require 'spec_helper'

describe RazorProductInfo do

  describe ".configure" do

    it "calls the block with the config object" do
      expect {|b| RazorProductInfo.configure(&b) }.to yield_with_args(duck_type(
        :host=, :version=, :auth_token=
      ))
    end

    it "sets up the Api object with the new values" do
      expect {
        RazorProductInfo.configure do |conf|
          conf.host = "http://new.host.com"
          conf.version = 2
        end
      }.to(change { RazorProductInfo::Api.options[:url] }.to("http://new.host.com/api/v2/"))
    end

  end

end
