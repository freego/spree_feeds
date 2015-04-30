module Spree
  module Admin
    class TaxonMapGoogleController < Spree::Admin::ResourceController

      def index
        @taxons = Spree::Taxon.leaves
      end

      def create
        params[:tax_id].each do |k, v|
          taxon_map = Spree::TaxonMapGoogle.find_or_initialize_by(taxon_id: k)
          taxon_map.product_type = v
          taxon_map.priority = params[:priority][k].to_i || 0
          taxon_map.save
        end

        if Spree::TaxonMapGoogle.count == params[:tax_id].size
          flash[:success] = "Google Base taxons mapping saved successfully."
        end

        redirect_to admin_taxon_map_google_index_path
      end

    end
  end
end
