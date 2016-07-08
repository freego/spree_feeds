module Spree
  class TaxonMapping < ActiveRecord::Base
    belongs_to :taxons
  end
end
