module Spree
  module Feeds
    class Base
      include ActionView::Helpers::SanitizeHelper

      def initialize
        @base_path = SpreeFeeds::Config.files_path
        @products = Spree::Product.feeds_base_scope
        @root_url = SpreeFeeds::Config.base_url
        FileUtils.mkdir_p(@base_path)
      end

      def perform
        # implement me
      end
    end
  end
end
