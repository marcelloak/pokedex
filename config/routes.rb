Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/tables' => 'application#tables'
  get '/timeline_tables' => 'application#timeline_tables'
  get '/caught_tables' => 'application#caught_tables'

  get '/routes' => 'pokedex#routes'
  get '/released_pokemon' => 'pokedex#released_pokemon'
  get '/released_shinies' => 'pokedex#released_shinies'
  get '/purchase_stats' => 'pokedex#purchase_stats'

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
    resources :form_fast_moves
    resources :form_charge_moves
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
    resources :form_breakthrough_timelines
    resources :costume_breakthrough_timelines
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
    resources :collection_challenges
    resources :rocket_members
    resources :rocket_member_shadows

    resources :pokemon_caught_timelines
    resources :form_caught_timelines
    resources :costume_caught_timelines
    resources :seen_pokemons
    resources :purchases
    resources :candies

    get '/type_chart' => 'type_interactions#type_chart'

    get '/fk/pokemons' => 'pokemons#foreign_keys'
    get '/fk/families' => 'families#foreign_keys'
  end

  get '*path', to: "static_pages#fallback_index_html", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end

end
