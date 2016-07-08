require 'csv'

module SpreeFeeds
  class Kelkoo < SpreeFeeds::Base

    def perform
      tags = SpreeFeeds::Config.kelkoo_tags
      file_path = "#{@base_path}/kelkoo_#{I18n.locale.upcase}.csv"
      tmp_name = "#{file_path}.tmp"

      options = { col_sep: ';' }
      CSV.open(tmp_name, "w", options) do |csv|
        csv << tags
        tags = tags.map { |t| t.gsub('-', '_') }

        @products.each do |product|
          helper = Helpers::Kelkoo.new(product.master, @root_url)
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
