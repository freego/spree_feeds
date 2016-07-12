module SpreeFeeds
  module Helpers
    class Facebook < SpreeFeeds::Helpers::Base
      def id
        "V#{@variant.id}"
      end

      def availability
        if @variant.in_stock?
          'in stock'
        elsif @variant.can_supply?
          'preorder'
        else
          'out of stock'
        end
      end

      def condition
        'new'
      end

      def description
        strip_tags(@product.description).gsub("\n", ' ').gsub("\r", '').
                                         squeeze(' ').
                                         strip[0, 4999]
      end

      def image_link
        if image = @product.images.first
          URI.join(@host, image.attachment.url(:original))
        end
      end

      def link
        Spree::Core::Engine.routes.url_helpers.product_url(@product, host: @host)
      end

      def title
        @product.name[0, 99]
      end

      def price
        "#{@variant.price.to_s} #{@product.currency}"
      end

      def mpn
        "V#{@variant.id}"
      end

      def additional_image_link
        @variant.images.drop(1).map do |image|
          URI.join(@host, image.attachment.url(:original))
        end.join(',')
      end

      def item_group_id
        "P#{@product.id}"
      end

      def google_product_category
        if mapping = @product.taxons.first.try(:taxon_mapping)
          mapping.google_taxon
        end
      end

    end
  end
end
