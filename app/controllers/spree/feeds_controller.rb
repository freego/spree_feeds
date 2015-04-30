module Spree
  class FeedsController < StoreController

    def google_shopping
      @products = Spree::Product.all
    end

    def trovaprezzi
      @products = Spree::Product.all
    end

  end
end
