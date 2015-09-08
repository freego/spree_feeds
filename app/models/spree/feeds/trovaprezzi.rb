# Mandatory attributes:
# - Name
# - Price
# - Code (SKU)
# - Link
# - Categories
#
# See doc/RequisitiTecnici_TrovaPrezziNetwork.pdf for more details

module Spree
  module Feeds
    class Trovaprezzi < Spree::Feeds::Base

      def perform
        tags = SpreeFeeds::Config.trovaprezzi_tags
        file_path = "#{@base_path}/trovaprezzi.xml"
        file = File.new("#{file_path}.tmp", "w")

        xml = Builder::XmlMarkup.new(target: file)
        xml.instruct! :xml, version: "1.0"
        xml.Products do
          @products.each do |product|
            variants = product.variants.many? ? product.variants : [product.master]
            variants.each do |variant|
              helper = SpreeFeeds::Helpers::TrovaprezziFeed.new(variant, @root_url)
              xml.Offer do
                tags.each do |t|
                  if t == 'image'
                    variant.images.each_with_index do |img, i|
                      xml.tag!(
                        "Image" + ( i != 0 ? (i + 1).to_s : '' ),
                        URI.join(@root_url, img.attachment.url(:original))
                      )
                    end
                  else
                    if helper.respond_to?(t) && value = helper.send(t)
                      xml.tag!(t.capitalize, strip_tags(value.to_s))
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
end
