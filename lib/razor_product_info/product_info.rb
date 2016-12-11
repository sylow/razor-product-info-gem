require 'concurrent'

module RazorProductInfo

  class ProductInfo < BaseModel
    collection_path 'product_info'

    @@all_cache = Concurrent::Map.new
    @@derived_cache = Concurrent::Map.new

    def self.find_by_sku(sku)
      return nil unless sku.present?
      all_by_sku[transform_sku_for_search(sku)]
    end

    def self.find_by_upc(upc)
      return nil unless upc.present?
      all_by_upc[transform_upc_for_search(upc)]
    end

    def self.all_cached
      @@all_cache.compute_if_absent('all') do
        all.to_a
      end
    end

    def self.reset_cache!
      @@all_cache.delete('all')
      reset_derived_cache!
    end

    def self.safely_refresh_cache!(&block)
      @@all_cache.compute('all') do
        all.to_a.tap do |a|
          raise "API returned no product infos" if a.empty?
          reset_derived_cache!
        end
      end
    rescue => e
      yield e if block_given?
    end

    private

      class << self
        def all_by_sku
          @@derived_cache.compute_if_absent('all_by_sku') do
            Hash[all_cached.map {|i| [transform_sku_for_search(i.sku), i] }]
          end
        end

        def all_by_upc
          @@derived_cache.compute_if_absent('all_by_upc') do
            Hash[
              all_cached.map {|i|
                upc = transform_upc_for_search(i.upc)
                upc && [upc, i]
              }.compact
            ]
          end
        end


        def transform_sku_for_search(sku)
          return nil unless sku && sku.present?
          sku.strip.downcase
        end

        def transform_upc_for_search(upc)
          return nil unless upc && upc.present?
          upc.strip.downcase.
            gsub('-', '').
            sub(/^0+/, '')
        end


        def reset_derived_cache!
          @@derived_cache.delete('all_by_sku')
          @@derived_cache.delete('all_by_upc')
        end
      end

  end

end
