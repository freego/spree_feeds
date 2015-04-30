Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :taxon_map_google
  end
end
