module SpreeFeeds
  module Helpers
    class TrovaprezziFeed
      include Spree::Core::Engine.routes.url_helpers
      include ActionView::Helpers::SanitizeHelper

      def initialize(variant, host)
        @variant = variant
        @product = variant.product
        @host = host
      end

      def code
        @variant.sku
      end

      def name
        @product.name
      end

      def description
        strip_tags(@product.description)
      end

      def link
        product_url(@product, host: @host)
      end

      def stock
        if @variant.total_on_hand > 1
          'Disponibile'
        elsif @variant.total_on_hand == 1
          'Disponibilità limitata'
        else
          'Non disponibile'
        end
      end

      def price
        @variant.respond_to?(:price) ? "#{@variant.price.to_s} #{@product.currency}" : "0 EUR"
      end

      def categories
        if taxon = @product.taxons.first
          taxon.pretty_name.downcase.gsub("->", ",")
        end
      end
    end
  end
end
