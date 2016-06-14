module SpreeFeeds
  module Helpers
    class Twenga < Base

      def merchant_ref
        "P#{@product.id}"
      end

      def merchant_id
        "P#{@product.id}/V#{@variant.id}"
      end

      def upc_ean
        ''
      end

      def product_url
        Spree::Core::Engine.routes.url_helpers.product_url(@product, host: @host)
      end

      def image_url
        if image = @product.images.first
          URI.join(@host, image.attachment.url(:original))
        end
      end

      def designation
        @product.name
      end

      def description
        strip_tags(@product.description)
      end

      def brand
        ''
      end

      def category
        if taxon = @product.taxons.first
          taxon.pretty_name.downcase.gsub("->", ">")
        end
      end

      def price
        @product.price.to_s
      end

      def unit_price
        @product.price.to_s
      end

      def availability
        @variant.total_on_hand
      end

      def condition
        '0' # 0 new, 1 used or refurbished
      end

      def energy_rating
        ''
      end

    end
  end
end
