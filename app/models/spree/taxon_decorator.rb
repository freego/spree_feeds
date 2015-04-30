module Spree
  Taxon.class_eval do
    has_one :taxon_map_google, dependent: :destroy
  end
end
