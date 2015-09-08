module SpreeFeeds
  class Configuration < Spree::Preferences::Configuration
    preference :run_every_hours, :integer, default: 12
    preference :files_path, :string, default: 'public/spree/feeds/'
    preference :base_url, :string, default: 'http://localhost:3000'

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
  end
end
