Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/tables' => 'application#tables'

  namespace :api do
    resources :generations
    resources :families
    resources :types
    resources :type_interactions
    resources :pokemons
    resources :forms
    resources :fast_moves
    resources :charge_moves
    resources :pokemon_fast_moves
    resources :pokemon_charge_moves
    resources :pokemon_levels
    resources :medals
  end

  get '*path', to: "static_pages#fallback_index_html", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end

end
