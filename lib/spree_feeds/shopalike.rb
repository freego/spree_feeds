require 'csv'

module SpreeFeeds
  class Shopalike < Base

    def perform
      tags = SpreeFeeds::Config.shopalike_tags
      file_path = "#{@base_path}/shopalike.csv"
      tmp_name = "#{file_path}.tmp"

      options = { col_sep: ';' }
      CSV.open(tmp_name, "w", options) do |csv|
        csv << tags
        tags = tags.map { |t| t.parameterize('_') }

        @products.each do |product|
          helper = Helpers::Shopalike.new(product.master, @root_url)
          csv << tags.map do |tag|
            if helper.respond_to?(tag) && value = helper.public_send(tag)
              strip_tags(value.to_s)
            end
          end
        end
      end

      File.rename(tmp_name, file_path)
    end

  end
end
