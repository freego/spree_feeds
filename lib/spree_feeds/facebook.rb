require 'csv'

module SpreeFeeds
  class Facebook < SpreeFeeds::Base

    def perform
      tags = SpreeFeeds::Config.facebook_tags
      file_path = "#{@base_path}/facebook.csv"
      tmp_name = "#{file_path}.tmp"

      options = { col_sep: ',' }
      CSV.open(tmp_name, "w", options) do |csv|
        csv << tags

        @products.each do |product|
          helper = Helpers::Facebook.new(product.master, @root_url)
          csv << tags.map do |tag|
            if helper.respond_to?(tag) && value = helper.public_send(tag)
              value
            end
          end
        end
      end

      File.rename(tmp_name, file_path)
    end

  end
end
