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


    def self.reset_cache!
      @@_all_cached = nil
      @@_all_by_sku = nil
      @@_all_by_upc = nil
    end
    reset_cache!

    private

      class << self
        def all_cached
          @@_all_cached ||= all.to_a
        end

        def all_by_sku
          @@_all_by_sku ||= Hash[all_cached.map {|i| [i.sku.downcase, i] }]
        end

        def all_by_upc
          @@_all_by_upc ||= Hash[all_cached.map {|i|
            i.upc && i.upc.present? && [i.upc.downcase, i]
          }.compact]
        end
      end

  end

end
