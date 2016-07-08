module Spree
  module Admin
    class TaxonMappingsController < Spree::Admin::ResourceController

      def index
        @taxons = Taxon.leaves
      end

      def create
        params[:mappings].each do |taxon_id, values|
          taxon_map = TaxonMapping.find_or_initialize_by(taxon_id: taxon_id)
          taxon_map.update_attributes(params[:mappings].require(taxon_id).permit!)
        end

        redirect_to admin_taxon_mappings_path, notice: 'OK'
      end

    end
  end
end
