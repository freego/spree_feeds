xml.instruct! :xml, :version => "1.0"
xml.Products do
  @products.each do |product|
    if product.variants.size > 0
      product.variants do |variant|
        xml << render(partial: 'spree/products/product_trovaprezzi', locals: { product: product, variant: variant })
      end
    else
        xml << render(partial: 'spree/products/product_trovaprezzi', locals: { product: product, variant: product.master })
    end
  end
end
