module SpreeFeeds
  module Helpers
    class Kelkoo < SpreeFeeds::Helpers::Base
      def offer_id
        "P#{@product.id}/V#{@variant.id}"
      end

      def title
        @product.name
      end

      def product_url
        Spree::Core::Engine.routes.url_helpers.product_url(@product, host: @host)
      end

      def price
        @variant.price.to_s
      end

      def image_url
        if image = @product.images.first
          URI.join(@host, image.attachment.url(:product))
        end
      end

      def image_url_2
        if image = @product.images.second
          URI.join(@host, image.attachment.url(:product))
        end
      end

      def image_url_3
        if image = @product.images.third
          URI.join(@host, image.attachment.url(:product))
        end
      end

      def image_url_4
        if image = @product.images.fourth
          URI.join(@host, image.attachment.url(:product))
        end
      end

      def merchant_category
        @product.taxons.first.try(:pretty_name)
      end

      def availability
        if @variant.in_stock?
          1 # available
        elsif @variant.can_supply?
          5 # backorderable
        else
          6 # not available
        end
      end

    end
  end
end
