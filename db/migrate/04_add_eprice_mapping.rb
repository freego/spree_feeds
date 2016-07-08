class AddEpriceMapping < ActiveRecord::Migration
  def self.up
    add_column :spree_taxon_mappings, :eprice_taxon, :text
  end

  def self.down
    remove_column :spree_taxon_mappings, :eprice_taxon
  end
end
