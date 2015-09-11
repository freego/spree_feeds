# Mandatory attributes:
# - Name
# - Price
# - Code (SKU)
# - Link
# - Categories
#
# See http://merchant.pagineprezzi.it/faq/index?menu=498 for more details
require 'csv'

module SpreeFeeds
  class Leguide < Base

    def perform
      tags = SpreeFeeds::Config.leguide_tags
      file_path = "#{@base_path}/leguide.csv"
      tmp_name = "#{file_path}.tmp"

      options = { col_sep: '|' }
      file = CSV.open(tmp_name, "w", options) do |csv|
        csv << tags

        @products.each do |product|
          variants = product.variants.many? ? product.variants : [product.master]
          variants.each do |variant|
            helper = Helpers::Leguide.new(variant, @root_url)
            csv << tags.map do |tag|
              if helper.respond_to?(tag) && value = helper.public_send(tag)
                strip_tags(value.to_s)
              end
            end
          end
        end
      end

      File.rename(tmp_name, file_path)
    end

  end
end
