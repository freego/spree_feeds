module SpreeFeeds
  module Helpers
    class Cvetta < SpreeFeeds::Helpers::Base
      def sku
        @variant.sku
      end

      def name
        @product.name
      end

      def image
        if image = @variant.images.first
          URI.join(@host, image.attachment.url(:original))
        end
      end

      def url_key
        product_url(@product, host: @host)
      end

      def price
        @variant.price.to_s
      end
    end
  end
end
