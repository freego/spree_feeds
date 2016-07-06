module SpreeFeeds
  module Helpers
    class EpriceProduct < Base

      def external_product_id_type
        'EAN'
      end

      def external_product_id
        # need custom logic
      end

      def part_number
        @variant.sku
      end

      def manufacturer
      end

      def item_name
        @product.name
      end

      def item_sku
        @variant.sku
      end

      def main_image_url
        if image = @variant.images.first
          URI.join(@host, image.attachment.url(:original))
        end
      end

      def other_image_url1
        if image = @variant.images.second
          URI.join(@host, image.attachment.url(:original))
        end
      end

      def other_image_url2
        if image = @variant.images.third
          URI.join(@host, image.attachment.url(:original))
        end
      end

      def product_description
        strip_tags(@product.description).gsub("\n", ' ').
                                         gsub("\r", '').
                                         squeeze(' ').
                                         strip
      end

      def recommended_browse_nodes
        if mapping = @product.taxons.first.try(:taxon_mapping)
          mapping.eprice_taxon
        end
      end

      def VAT
        '22'
      end

      def website_shipping_weight
        @variant.weight
      end

      def website_shipping_weight_unit_of_measure
        'g'
      end
    end
  end
end
