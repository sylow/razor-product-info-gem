require 'faraday'
require 'faraday_middleware'
require 'hashie'

module RazorProductInfo

  class Client
    attr_reader :connection, :auth_token, :base_url

    def initialize(auth_token: RazorProductInfo.config.auth_token, base_url: RazorProductInfo.config.base_url)
      @auth_token = auth_token
      @base_url = base_url
      @connection = Faraday.new(url: @base_url) do |conn|
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

      r.body
    end

    def respond_to_missing?(method, include_private = false)
      [:get, :post, :patch, :delete].include?(method)
    end

  end

end
