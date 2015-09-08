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

helper = SpreeFeeds::Helpers::GoogleShoppingFeed.new(product, variant, root_url)
tags = SpreeFeeds::Config.google_shopping_tags
tags_with_cdata = SpreeFeeds::Config.google_shopping_tags_with_cdata

xml.item do
  tags.each do |t|
    if t == 'image'
      if variant.images.size > 0
        xml.g :image_link, URI.join(request.url, variant.images.first.attachment.url(:original))
      else
        xml.g :image_link, image_url('noimage/large.png')
      end
    elsif t == 'additional_image_link'
      variant.images.drop(1).each do |img|
        xml.g :additional_image_link, URI.join(request.url, img.attachment.url(:original))
      end
    else
      if helper.respond_to?(t.to_sym) && value = helper.send(t)
        if tags_with_cdata.include? t
          xml.tag!("g:#{t}") { xml.cdata!(value) }
        else
          xml.g t.to_sym, value
        end
      end
    end
  end
end
