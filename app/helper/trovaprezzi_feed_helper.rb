class TrovaprezziFeedHelper
  include Spree::Core::Engine.routes.url_helpers

  def initialize(variant, host)
    @variant = variant
    @product = variant.product
    @host = host
  end

  def code
    @variant.sku
  end

  def name
    @product.name
  end

  def description
    @product.description
  end

  def link
    product_url(@product, host: @host)
  end

  def stock
    if @variant.total_on_hand > 1
      'Disponibile'
    elsif @variant.total_on_hand == 1
      'Disponibilità limitata'
    else
      'Non disponibile'
    end
  end

  def price
    @variant.respond_to?(:price) ? "#{@variant.price.to_s} #{@product.currency}" : "0 EUR"
  end

  def categories
    categories = []
    @product.taxons.each do |t|
      categories << t.name.downcase
    end
    categories.join('; ')
  end
end

