class RemovePriority < ActiveRecord::Migration
  def self.up
    remove_column :spree_taxon_mappings, :priority
  end

  def self.down
    add_column :spree_taxon_mappings, :priority, :integer
  end
end
