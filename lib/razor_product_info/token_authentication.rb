module RazorProductInfo

  class TokenAuthentication < Faraday::Middleware
    def call(env)
      env[:request_headers]["Authorization"] = "Token token=#{RazorProductInfo.config.auth_token}"
      @app.call(env)
    end
  end

end
