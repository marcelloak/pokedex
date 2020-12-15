Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/tables' => 'application#tables'
  get '/timeline_tables' => 'application#timeline_tables'
  get '/caught_tables' => 'application#caught_tables'

  namespace :api do
    resources :players
    resources :generations
    resources :families
    resources :types
    resources :type_interactions
    resources :pokemons
    resources :forms
    resources :costumes
    resources :fast_moves
    resources :charge_moves
    resources :pokemon_fast_moves
    resources :pokemon_charge_moves
    resources :pokemon_levels
    resources :medals

    resources :pokemon_timelines
    resources :form_timelines
    resources :costume_timelines
    resources :shadow_timelines
    resources :shiny_timelines
    resources :shiny_form_timelines
    resources :shiny_costume_timelines
    resources :shiny_shadow_timelines
    resources :raid_timelines
    resources :form_raid_timelines
    resources :costume_raid_timelines
    resources :breakthrough_timelines
    resources :special_research_timelines
    resources :gbl_timelines
    resources :special_league_timelines
    resources :special_league_type_limits
    resources :season_timelines
    resources :event_timelines
    resources :item_timelines
    resources :feature_timelines
    resources :medal_timelines
    resources :special_day_types
    resources :special_days
    resources :form_special_days
    resources :costume_special_days

    resources :pokemon_caught_timelines
    resources :form_caught_timelines
    resources :costume_caught_timelines

    get '/type_chart' => 'type_interactions#type_chart'
  end

  get '*path', to: "static_pages#fallback_index_html", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end

end
