require 'faraday'
require 'faraday_middleware'
require 'hashie'

module RazorProductInfo

  class Client
    attr_reader :connection, :auth_token

    def initialize(auth_token: nil, base_url: RazorProductInfo::DEFAULT_BASE_URL)
      @auth_token = auth_token
      @connection = Faraday.new(url: base_url) do |conn|
        conn.request :json

        conn.response :json
        #conn.response :mashify

        conn.adapter :net_http
      end
    end

    def method_missing(method, *args)
      r = connection.send method, *args do |req|
        req.headers['Authorization'] = "Token token=#{auth_token}" if auth_token
      end

      unless r.success?
        raise Error, r.body.fetch('error', "unknown error")
      end

      Hashie::Mash.new(r.body)
    end

    def respond_to_missing?(method, include_private = false)
      [:get, :post, :patch, :delete].include?(method)
    end

  end

end
