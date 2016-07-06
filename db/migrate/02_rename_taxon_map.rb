class RenameTaxonMap < ActiveRecord::Migration
  def self.up
    rename_table :taxon_map_google, :spree_taxon_mappings
    rename_column :spree_taxon_mappings, :product_type, :google_taxon
  end

  def self.down
    rename_table :spree_taxon_mappings, :taxon_map_google
    rename_column :taxon_map_google, :google_taxon, :product_type
  end
end
