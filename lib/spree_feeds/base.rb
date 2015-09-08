module SpreeFeeds
  class Base
    include ActionView::Helpers::SanitizeHelper

    def initialize
      @base_path = Config.files_path
      @products = Spree::Product.feeds_base_scope
      @root_url = Config.base_url
      FileUtils.mkdir_p(@base_path)
    end

    def perform
      # implement me
    end
  end
end
