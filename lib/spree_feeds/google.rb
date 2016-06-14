# RSS specification:
# - https://support.google.com/merchants/answer/1344057
# - https://support.google.com/merchants/answer/188494
# - https://support.google.com/merchants/answer/160589
# - https://support.google.com/merchants/answer/1347943
# - https://support.google.com/merchants/answer/160081
#
# Mandatory attributes:
# - id
# - title
# - description
# - google_product_category
# - link
# - image_link
# - condition
# - availability
# - price
# - item_group_id (only if the product has variants)

module SpreeFeeds
  class Google < Base

    def perform
      tags = Config.google_shopping_tags
      file_path = "#{@base_path}/google.xml"
      file = File.new("#{file_path}.tmp", "w")

      xml = Builder::XmlMarkup.new(target: file)
      xml.instruct! :xml, version: "1.0"
      xml.rss version: "2.0", "xmlns:g" => "http://base.google.com/ns/1.0" do
        xml.channel do
          xml.title Config.google_shopping_rss_title
          xml.description Config.google_shopping_rss_description
          xml.link @root_url

          @products.find_each(batch_size: 200) do |product|
            variants = product.variants.many? ? product.variants : [product.master]
            variants.each do |variant|
              helper = Helpers::GoogleShoppingFeed.new(variant, @root_url)
              xml.item do
                tags.map(&:to_sym).each do |t|
                  if helper.respond_to?(t) && value = helper.send(t)
                    if value.is_a?(Array)
                      value.each { |v| xml.g t, v.to_s }
                    elsif value.is_a?(Hash)
                      xml.tag!('g:shipping') { value.each { |k, v| xml.g k, v } }
                    else
                      xml.g t, value.to_s
                    end
                  end
                end
              end
            end
          end
        end
      end

      file.close
      File.rename("#{file_path}.tmp", file_path)
    end

  end
end
