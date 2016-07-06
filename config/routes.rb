Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :taxon_mappings
  end
end
