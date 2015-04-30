module Spree
  class TaxonMapGoogle < ActiveRecord::Base
    self.table_name = "taxon_map_google"
    belongs_to :taxons
  end
end