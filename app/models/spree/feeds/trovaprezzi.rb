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
        file_path = "#{@base_path}/trovaprezzi.xml"
        file = File.new("#{file_path}.tmp", "w")
        xml = Builder::XmlMarkup.new(target: file)

        xml.instruct! :xml, version: "1.0"
        xml.Products do
          @products.each do |product|
            variants = product.variants.many? ? product.variants : [product.master]
            variants.each do |variant|
              xml.Offer do
                xml.Name product.name
                xml.Brand product.brand_name if product.brand_name.present?
                xml.tag!("Description") { xml.cdata!(product.description) }
                xml.Price variant.price
                xml.Code variant.sku
                xml.Link product_url(product)
                xml.Stock variant.total_on_hand
                categories = []
                product.taxons.each do |t|
                  categories << t.name.downcase
                end
                xml.Categories categories.join('; ')
                variant.images.each_with_index do |img, i|
                  xml.tag!(
                    "Image" + ( i != 0 ? (i + 1).to_s : '' ),
                    URI.join(request.url, img.attachment.url(:original))
                  )
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
