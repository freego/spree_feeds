module SpreeFeeds
  module Helpers
    class Base
      include Spree::Core::Engine.routes.url_helpers
      include ActionView::Helpers::SanitizeHelper

      def initialize(variant, host)
        @variant = variant
        @product = variant.product
        @host = host
      end

      def description
        strip_tags(@product.description).gsub("\n", ' ').gsub("\r", '').squeeze(' ').strip
      end

    end
  end
end
