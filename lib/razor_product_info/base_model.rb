module RazorProductInfo

  class BaseModel < Hash
    include Hashie::Extensions::MethodAccessWithOverride
    include Hashie::Extensions::Coercion
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::MergeInitializer

    private

      def self.client
        RazorProductInfo.global_client
      end

  end

end
