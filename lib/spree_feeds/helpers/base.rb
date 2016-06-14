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

    end
  end
end
