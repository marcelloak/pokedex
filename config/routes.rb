Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :generations do
      resources :pokemons do
        resources :forms
      end
    end
    resources :fast_moves do
      resources :pokemon_fast_moves
    end
    resources :charge_moves do
      resources :pokemon_charge_moves
    end
    resources :types do
      resources :type_interactions
    end
    resources :families
    resources :pokemon_levels
    resources :medals
  end

  get '*path', to: "static_pages#fallback_index_html", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end

end
