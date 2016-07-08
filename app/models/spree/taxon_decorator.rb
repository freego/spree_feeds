module Spree
  Taxon.class_eval do
    has_one :taxon_mapping, dependent: :destroy
  end
end
