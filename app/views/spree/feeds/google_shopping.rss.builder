xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:g" => "http://base.google.com/ns/1.0" do
  xml.channel do
    xml.title SpreeFeeds::Config.google_shopping_rss_title
    xml.descrition SpreeFeeds::Config.google_shopping_rss_description
    xml.link root_url
    @products.each do |product|
      if product.variants.size > 0
          product.variants do |variant|
              xml << render(partial: 'spree/products/product_google_shopping', locals: { product: product, variant: variant, builder: xml })
          end
      else
          xml << render(partial: 'spree/products/product_google_shopping', locals: { product: product, variant: product.master, builder: xml })
      end
    end
  end
end
