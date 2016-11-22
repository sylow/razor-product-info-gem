module RazorProductInfo

  class ErrorHandler < Faraday::Middleware
    def call(env)
      @app.call(env).tap do |resp|
        raise Unauthorized if resp.status == 401
        raise ServerError if resp.status.to_i/100 == 5 # 5xx
      end
    end
  end

end
