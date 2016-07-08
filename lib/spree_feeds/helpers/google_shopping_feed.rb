module SpreeFeeds
  module Helpers
    class GoogleShoppingFeed < SpreeFeeds::Helpers::Base

      def id
        "P#{@product.id}/V#{@variant.id}"
      end

      def title
        @product.respond_to?(:title) ? @product.title : @product.name
      end

      def google_product_category
        if mapping = @product.taxons.first.try(:taxon_mapping)
          mapping.google_taxon
        end
      end

      def product_type
        if taxon = @product.taxons.first
          taxon.pretty_name.gsub("->", ">")
        end
      end

      def link
        product_url(@product, host: @host)
      end

      def image_link
        if image = @variant.images.first
          URI.join(@host, image.attachment.url(:original))
        end
      end

      def additional_image_link
        @variant.images.drop(1).map do |image|
          URI.join(@host, image.attachment.url(:original))
        end
      end

      def condition
        @product.respond_to?(:condition) ? @product.condition : 'new'
      end

      def availability
        if @variant.respond_to?(:availability)
          @variant.availability
        else
          @variant.in_stock? ? 'in stock' : 'out of stock'
        end
      end

      def price
        @variant.respond_to?(:price) ? "#{@variant.price.to_s} #{@product.currency}" : "0 EUR"
      end

      def gender
        @product.respond_to?(:gender) ? @product.gender : nil
      end
    end
  end
end
