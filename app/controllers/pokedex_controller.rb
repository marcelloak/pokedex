class PokedexController < ApplicationController
  def needed_pokemon
    now = DateTime.now
    pokemons = Pokemon.all
    released = PokemonTimeline.where('released < ?', now).pluck(:pokemon_id)
    caught = PokemonCaughtTimeline.where(:shiny => false).pluck(:target_evolution_id)
    need = {}
    (pokemons.select { |pokemon| released.include?(pokemon[:id]) && !caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = {
        id: pokemon[:id],
        name: pokemon[:name],
        need: 'Y'
      }
    }

    shiny_released = ShinyTimeline.where('released < ?', now).pluck(:pokemon_id)
    shiny_caught = PokemonCaughtTimeline.where(:shiny => 'Y').pluck(:target_evolution_id)
    (pokemons.select { |pokemon| shiny_released.include?(pokemon[:id]) && !shiny_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shiny: 'Y' } : {
        id: pokemon[:id],
        name: pokemon[:name],
        shiny: 'Y'
      }
    }

    needed = []
    need.keys.each { |key| needed.push(need[key]) }

    render :json => conversion(needed)
  end

  def released_pokemon
    now = DateTime.now
    pokemons = Pokemon.all
    generations = Generation.all
    families = Family.all
    types = Type.all
    released = PokemonTimeline.where('released < ?', now).pluck(:pokemon_id)
    released = (pokemons.select { |pokemon| released.include?(pokemon[:id])}).as_json.map { |pokemon|
      {
        **pokemon.symbolize_keys,
        evolves_from_id: { id: pokemon.symbolize_keys[:evolves_from_id], name: pokemon.symbolize_keys[:evolves_from_id] ? (pokemons.find {|x| x[:id] == pokemon.symbolize_keys[:evolves_from_id]})[:name] : pokemon.symbolize_keys[:evolves_from_id] },
        generation_id: { id: pokemon.symbolize_keys[:generation_id], name: (generations.find {|x| x[:id] == pokemon.symbolize_keys[:generation_id]})[:name] },
        family_id: { id: pokemon.symbolize_keys[:family_id], name: (families.find {|x| x[:id] == pokemon.symbolize_keys[:family_id]})[:name] },
        primary_type_id: { id: pokemon.symbolize_keys[:primary_type_id], name: (types.find {|x| x[:id] == pokemon.symbolize_keys[:primary_type_id]})[:icon] },
        secondary_type_id: { id: pokemon.symbolize_keys[:secondary_type_id], name: pokemon.symbolize_keys[:secondary_type_id] ? (types.find {|x| x[:id] == pokemon.symbolize_keys[:secondary_type_id]})[:icon] : pokemon.symbolize_keys[:secondary_type_id] }
      }
    }

    render :json => conversion(released)
  end
  
  def released_shinies
    now = DateTime.now
    pokemons = Pokemon.all
    generations = Generation.all
    families = Family.all
    types = Type.all
    released = ShinyTimeline.where('released < ?', now).pluck(:pokemon_id)
    released = (pokemons.select { |pokemon| released.include?(pokemon[:id])}).as_json.map { |pokemon|
      {
        **pokemon.symbolize_keys,
        evolves_from_id: { id: pokemon.symbolize_keys[:evolves_from_id], name: pokemon.symbolize_keys[:evolves_from_id] ? (pokemons.find {|x| x[:id] == pokemon.symbolize_keys[:evolves_from_id]})[:name] : pokemon.symbolize_keys[:evolves_from_id] },
        generation_id: { id: pokemon.symbolize_keys[:generation_id], name: (generations.find {|x| x[:id] == pokemon.symbolize_keys[:generation_id]})[:name] },
        family_id: { id: pokemon.symbolize_keys[:family_id], name: (families.find {|x| x[:id] == pokemon.symbolize_keys[:family_id]})[:name] },
        primary_type_id: { id: pokemon.symbolize_keys[:primary_type_id], name: (types.find {|x| x[:id] == pokemon.symbolize_keys[:primary_type_id]})[:icon] },
        secondary_type_id: { id: pokemon.symbolize_keys[:secondary_type_id], name: pokemon.symbolize_keys[:secondary_type_id] ? (types.find {|x| x[:id] == pokemon.symbolize_keys[:secondary_type_id]})[:icon] : pokemon.symbolize_keys[:secondary_type_id] }
      }
    }

    render :json => conversion(released)
  end
  
  def unreleased_shinies
    now = DateTime.now
    pokemons = Pokemon.all
    generations = Generation.all
    families = Family.all
    types = Type.all
    released = PokemonTimeline.where('released < ?', now).pluck(:pokemon_id)
    shinies = ShinyTimeline.where('released < ?', now).pluck(:pokemon_id)
    released = (pokemons.select { |pokemon| released.include?(pokemon[:id]) && !shinies.include?(pokemon[:id]) }).as_json.map { |pokemon|
      {
        **pokemon.symbolize_keys,
        evolves_from_id: { id: pokemon.symbolize_keys[:evolves_from_id], name: pokemon.symbolize_keys[:evolves_from_id] ? (pokemons.find {|x| x[:id] == pokemon.symbolize_keys[:evolves_from_id]})[:name] : pokemon.symbolize_keys[:evolves_from_id] },
        generation_id: { id: pokemon.symbolize_keys[:generation_id], name: (generations.find {|x| x[:id] == pokemon.symbolize_keys[:generation_id]})[:name] },
        family_id: { id: pokemon.symbolize_keys[:family_id], name: (families.find {|x| x[:id] == pokemon.symbolize_keys[:family_id]})[:name] },
        primary_type_id: { id: pokemon.symbolize_keys[:primary_type_id], name: (types.find {|x| x[:id] == pokemon.symbolize_keys[:primary_type_id]})[:icon] },
        secondary_type_id: { id: pokemon.symbolize_keys[:secondary_type_id], name: pokemon.symbolize_keys[:secondary_type_id] ? (types.find {|x| x[:id] == pokemon.symbolize_keys[:secondary_type_id]})[:icon] : pokemon.symbolize_keys[:secondary_type_id] }
      }
    }

    render :json => conversion(released)
  end

  def purchase_stats
    stats = []
    if Purchase.count() > 0
      now = DateTime.now
      release = Date.parse('06-07-2016')
      days = (now - release).to_f
      months = days / 30
      years = months / 12

      orders = Purchase.count()
      total_coins = Purchase.sum(:coins)
      total_dollars = Purchase.sum(:price)
      total_coin_dollars = Purchase.where(:ticket => false, :box => false).sum(:price)
      dollars_spent_last_week = Purchase.where('purchased > ?', now - 7).sum(:price)
      dollars_spent_last_month = Purchase.where('purchased > ?', now - 30).sum(:price)
      dollars_spent_last_quarter = Purchase.where('purchased > ?', now - 90).sum(:price)
      dollars_spent_last_year = Purchase.where('purchased > ?', now - 365).sum(:price)

      stats[0] = {
        total_dollars: total_dollars,
        total_coins: total_coins,
        total_tickets: Purchase.where(:ticket => 'Y').count(),
        total_coin_dollars: total_coin_dollars,
        total_ticket_dollars: Purchase.where(:ticket => 'Y').sum(:price),
        dollars_per_month: (total_dollars / months).round(2),
        dollars_per_year: (total_dollars / years).round(2),
        dollars_per_order: Purchase.average(:price).round(2),
        coins_per_order: (total_coins / Purchase.where(:ticket => false, :box => false).count()).round(2),
        coins_per_dollar: (total_coins / total_coin_dollars).round(2),
        orders_per_month: (orders / months).round(2),
        orders_per_year: (orders / years).round(2),
        dollars_spent_last_week: dollars_spent_last_week,
        dollars_spent_last_month: dollars_spent_last_month,
        dollars_spent_last_quarter: dollars_spent_last_quarter,
        dollars_spent_last_year: dollars_spent_last_year,
        dollars_spent_per_day_last_week: (dollars_spent_last_week / 7.0).round(2),
        dollars_spent_per_day_last_month: (dollars_spent_last_month / 30.0).round(2),
        dollars_spent_per_day_last_quarter: (dollars_spent_last_quarter / 90.0).round(2),
        dollars_spent_per_day_last_year: (dollars_spent_last_year / 365.0).round(2),
        months: months.round(2),
        years: years.round(2)
      }
    end
    render :json => conversion(stats)
  end
  
  def routes
    render :json => ['needed_pokemon', 'released_pokemon', 'released_shinies', 'unreleased_shinies', 'purchase_stats']
  end

  def conversion(records)
    return records.empty? ? [] : [records.as_json[0].symbolize_keys.keys, *records]
  end
end
