module RazorProductInfo

  class Error < StandardError; end

  class ClientError < Error; end
  class Unauthorized < ClientError; end

  class ServerError < Error; end

end
