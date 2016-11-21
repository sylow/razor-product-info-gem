require 'memoist'

module RazorProductInfo

  class ProductInfo < BaseModel
    collection_path 'product_info'


    def self.find_by_sku(sku)
      return nil unless sku.present?
      all_by_sku[sku.downcase]
    end

    def self.find_by_upc(upc)
      return nil unless upc.present?

      info = all_by_upc[upc.downcase]
      return info if info

      return find_by_upc(upc.gsub(/^0+/, '')) if upc =~ /^0+/
    end

    # def self.find_by_upc(upc)
    #   return nil unless upc.present?
    #   cache_all!

    #   info = where(Sequel.function(:lower, :upc) => upc.downcase).first
    #   return info if info

    #   where(Sequel.function(:lower, :upc) => upc.downcase.gsub(/^0+/, '')).first
    # end


    private

      class << self
        extend Memoist

        def all_cached
          all.to_a
        end
        memoize :all_cached

        def all_by_sku
          all_cached.map {|i| [i.sku.downcase, i] }.to_h
        end
        memoize :all_by_sku

        def all_by_upc
          all_cached.map {|i| [i.upc.downcase, i] }.to_h
        end
        memoize :all_by_upc
      end

  end

end
