module SpreeFeeds
  module Helpers
    class Shopalike < Base

      def sku
        @product.id
      end

      def name
        @product.name
      end

      def top_category
        if taxon = @product.taxons.first
          taxon.ancestors.find_by(depth: 1).try(:name)
        end
      end

      def category
        if taxon = @product.taxons.first
          taxon.ancestors.find_by(depth: 2).try(:name)
        end
      end

      def description
        strip_tags(@product.description)
      end

      def price
        @product.price.to_s
      end

      def image_url
        if image = @product.images.first
          URI.join(@host, image.attachment.url(:original))
        end
      end

      def deeplink_url
        Spree::Core::Engine.routes.url_helpers.product_url(@product, host: @host)
      end

      def currency
        @product.currency
      end

    end
  end
end
