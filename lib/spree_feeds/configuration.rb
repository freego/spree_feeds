module SpreeFeeds
  class Configuration < Spree::Preferences::Configuration
    preference :files_path, :string, default: 'public/spree/feeds/'
    preference :base_url, :string, default: 'http://localhost:3000'
    preference :mappings, :array, default: ['google']

    preference :google_shopping_rss_title, :string, default: 'Title goes here'
    preference :google_shopping_rss_description, :string, default: 'This is the description'
    preference :google_shopping_tags, :array, default: [
      'id',
      'title',
      'description',
      'google_product_category',
      'product_type',
      'link',
      'image_link',
      'additional_image_link',
      'condition',
      'availability',
      'price'
    ]

    preference :trovaprezzi_tags, :array, default: [
      'name',
      'description',
      'price',
      'code',
      'link',
      'stock',
      'categories',
      'image'
    ]

    preference :leguide_tags, :array, default: [
      'category',
      'offer_id',
      'name',
      'description',
      'price',
      'product_url',
      'image_url',
      'shipping',
      'availability',
      'guarantee'
    ]

    preference :shopalike_tags, :array, default: [
      'SKU',
      'NAME',
      'TOP CATEGORY',
      'CATEGORY',
      'DESCRIPTION',
      'PRICE',
      'IMAGE URL',
      'DEEPLINK URL',
      'CURRENCY'
    ]

    preference :twenga_tags, :array, default: [
      'merchant_ref',
      'merchant_id',
      'upc_ean',
      'product_url',
      'image_url',
      'designation',
      'description',
      'brand',
      'category',
      'price',
      'unit_price',
      'availability',
      'condition',
      'energy_rating'
    ]

    preference :eprice_product_tags, :array, default: [
      'external_product_id_type',
      'external_product_id',
      'part_number',
      'manufacturer',
      'item_name',
      'item_sku',
      'main_image_url',
      'other_image_url1',
      'other_image_url2',
      'product_description',
      'recommended_browse_nodes',
      'VAT',
      'website_shipping_weight',
      'website_shipping_weight_unit_of_measure'
    ]

    preference :eprice_offer_tags, :array, default: [
      'sku',
      'product_id',
      'product_id_type',
      'price',
      'quantity',
      'state',
      'fulfillment_latency',
      'logistic_class'
    ]
  end
end
