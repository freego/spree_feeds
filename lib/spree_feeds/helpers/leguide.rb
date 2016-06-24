module SpreeFeeds
  module Helpers
    class Leguide < SpreeFeeds::Helpers::Base

      def category
        if taxon = @product.taxons.first
          taxon.pretty_name.downcase.gsub("->", ">")
        end
      end

      def offer_id
        "P#{@product.id}/V#{@variant.id}"
      end

      def name
        @product.name
      end

      def price
        @variant.price.to_s
      end

      def product_url
        Spree::Core::Engine.routes.url_helpers.product_url(@product, host: @host)
      end

      def image_url
        if image = @variant.images.first
          URI.join(@host, @variant.images.first.attachment.url(:original))
        end
      end

      def shipping
        '0'
      end

      def availability
        '0'
      end

      def guarantee
        '2'
      end

    end
  end
end
