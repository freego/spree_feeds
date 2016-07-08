module SpreeFeeds
  module Helpers
    class EpriceOffer < Base
      def sku
        @variant.sku
      end

      def product_id
        # need custom logic
      end

      def product_id_type
        'EAN'
      end

      def price
        @variant.price.to_s
      end

      def quantity
        @variant.total_on_hand
      end

      def state
        '11' # new product
      end

      def fulfillment_latency
        1
      end

      def logistic_class
        'U'
      end

      private

      def logistic_classes
        {
          'U' => 6.99,
          'Z' => 7.99,
          'B' => 9.99,
          'C' => 9.99,
          'D' => 9.99,
          'E' => 11.99,
          'F' => 12.99,
          'G' => 12.99,
          'H' => 19.99,
          'I' => 29.99,
          'L' => 39.99,
          'M' => 59.00,
          'N' => 69.00,
          'O' => 79.00,
          'P' => 89.00,
          'Q' => 99.00,
          'R' => 119.00,
          'S' => 149.00,
          'T' => 250.00
        }
      end

    end
  end
end
