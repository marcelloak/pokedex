class PokedexController < ApplicationController
  def needed_pokemon
    now = DateTime.now
    pokemons = Pokemon.all
    need = {}
    
    released = PokemonTimeline.where('released < ?', now).pluck(:pokemon_id)
    caught = PokemonCaughtTimeline.where(:shiny => false, :shadow => false, :purified => false).pluck(:target_evolution_id)
    (pokemons.select { |pokemon| released.include?(pokemon[:id]) && !caught.include?(pokemon[:id]) }).each { |pokemon|
    need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], need: 'Y' } : { id: pokemon[:id], name: pokemon[:name], need: 'Y' }
    }
    
    iv_caught = PokemonCaughtTimeline.where(:shiny => false, :shadow => false, :purified => false, :high_iv => true).pluck(:target_evolution_id)
    (pokemons.select { |pokemon| released.include?(pokemon[:id]) && !iv_caught.include?(pokemon[:id]) }).each { |pokemon|
    need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], iv: 'Y' } : { id: pokemon[:id], name: pokemon[:name], iv: 'Y' }
  }

    shiny_released = ShinyTimeline.where('released < ?', now).pluck(:pokemon_id)
    shiny_caught = PokemonCaughtTimeline.where(:shiny => true, :shadow => false, :purified => false).pluck(:target_evolution_id)
    (pokemons.select { |pokemon| shiny_released.include?(pokemon[:id]) && !shiny_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shiny: 'Y' } : { id: pokemon[:id], name: pokemon[:name], shiny: 'Y' }
    }

    shadow_released = ShadowTimeline.where('released < ?', now).pluck(:pokemon_id)
    shadow_caught = PokemonCaughtTimeline.where(:shiny => false, :shadow => true).pluck(:target_evolution_id)
    purified_caught = PokemonCaughtTimeline.where(:shiny => false, :purified => true).pluck(:target_evolution_id)
    (pokemons.select { |pokemon| shadow_released.include?(pokemon[:id]) && !shadow_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shadow: 'Y' } : { id: pokemon[:id], name: pokemon[:name], shadow: 'Y' }
    }
    (pokemons.select { |pokemon| shadow_released.include?(pokemon[:id]) && !purified_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], purified: 'Y' } : { id: pokemon[:id], name: pokemon[:name], purified: 'Y' }
    }

    shiny_shadow_released = ShinyShadowTimeline.where('released < ?', now).pluck(:pokemon_id)
    shiny_shadow_caught = PokemonCaughtTimeline.where(:shiny => true, :shadow => true).pluck(:target_evolution_id)
    shiny_purified_caught = PokemonCaughtTimeline.where(:shiny => true, :purified => true).pluck(:target_evolution_id)
    (pokemons.select { |pokemon| shiny_shadow_released.include?(pokemon[:id]) && !shiny_shadow_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shiny_shadow: 'Y' } : { id: pokemon[:id], name: pokemon[:name], shiny_shadow: 'Y' }
    }
    (pokemons.select { |pokemon| shiny_shadow_released.include?(pokemon[:id]) && !shiny_purified_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shiny_purified: 'Y' } : { id: pokemon[:id], name: pokemon[:name], shiny_purified: 'Y' }
    }

    male_caught = PokemonCaughtTimeline.where(:shiny => false, :shadow => false, :purified => false, :gender => 'M').pluck(:target_evolution_id)
    female_caught = PokemonCaughtTimeline.where(:shiny => false, :shadow => false, :purified => false, :gender => 'F').pluck(:target_evolution_id)
    (pokemons.select { |pokemon| pokemon[:gender_variant] && released.include?(pokemon[:id]) && !male_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], need: 'M' } : { id: pokemon[:id], name: pokemon[:name], need: 'M' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && released.include?(pokemon[:id]) && !female_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], need: 'F' } : { id: pokemon[:id], name: pokemon[:name], need: 'F' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && released.include?(pokemon[:id]) && !male_caught.include?(pokemon[:id]) && !female_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], need: 'MF' } : { id: pokemon[:id], name: pokemon[:name], need: 'MF' }
    }
    
    male_iv_caught = PokemonCaughtTimeline.where(:shiny => false, :shadow => false, :purified => false, :high_iv => true, :gender => 'M').pluck(:target_evolution_id)
    female_iv_caught = PokemonCaughtTimeline.where(:shiny => false, :shadow => false, :purified => false, :high_iv => true, :gender => 'F').pluck(:target_evolution_id)
    (pokemons.select { |pokemon| pokemon[:gender_variant] && released.include?(pokemon[:id]) && !male_iv_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], iv: 'M' } : { id: pokemon[:id], name: pokemon[:name], iv: 'M' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && released.include?(pokemon[:id]) && !female_iv_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], iv: 'F' } : { id: pokemon[:id], name: pokemon[:name], iv: 'F' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && released.include?(pokemon[:id]) && !male_iv_caught.include?(pokemon[:id]) && !female_iv_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], iv: 'MF' } : { id: pokemon[:id], name: pokemon[:name], iv: 'MF' }
    }

    shiny_male_caught = PokemonCaughtTimeline.where(:shiny => true, :shadow => false, :purified => false, :gender => 'M').pluck(:target_evolution_id)
    shiny_female_caught = PokemonCaughtTimeline.where(:shiny => true, :shadow => false, :purified => false, :gender => 'F').pluck(:target_evolution_id)
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shiny_released.include?(pokemon[:id]) && !shiny_male_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shiny: 'M' } : { id: pokemon[:id], name: pokemon[:name], shiny: 'M' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shiny_released.include?(pokemon[:id]) && !shiny_female_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shiny: 'F' } : { id: pokemon[:id], name: pokemon[:name], shiny: 'F' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shiny_released.include?(pokemon[:id]) && !shiny_male_caught.include?(pokemon[:id]) && !shiny_female_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shiny: 'MF' } : { id: pokemon[:id], name: pokemon[:name], shiny: 'MF' }
    }

    shadow_male_caught = PokemonCaughtTimeline.where(:shiny => false, :shadow => true, :purified => false, :gender => 'M').pluck(:target_evolution_id)
    shadow_female_caught = PokemonCaughtTimeline.where(:shiny => false, :shadow => true, :purified => false, :gender => 'F').pluck(:target_evolution_id)
    purified_male_caught = PokemonCaughtTimeline.where(:shiny => false, :shadow => false, :purified => true, :gender => 'M').pluck(:target_evolution_id)
    purified_female_caught = PokemonCaughtTimeline.where(:shiny => false, :shadow => false, :purified => true, :gender => 'F').pluck(:target_evolution_id)
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shadow_released.include?(pokemon[:id]) && !shadow_male_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shadow: 'M' } : { id: pokemon[:id], name: pokemon[:name], shadow: 'M' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shadow_released.include?(pokemon[:id]) && !shadow_female_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shadow: 'F' } : { id: pokemon[:id], name: pokemon[:name], shadow: 'F' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shadow_released.include?(pokemon[:id]) && !shadow_male_caught.include?(pokemon[:id]) && !shadow_female_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shadow: 'MF' } : { id: pokemon[:id], name: pokemon[:name], shadow: 'MF' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shadow_released.include?(pokemon[:id]) && !purified_male_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], purified: 'M' } : { id: pokemon[:id], name: pokemon[:name], purified: 'M' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shadow_released.include?(pokemon[:id]) && !purified_female_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], purified: 'F' } : { id: pokemon[:id], name: pokemon[:name], purified: 'F' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shadow_released.include?(pokemon[:id]) && !purified_male_caught.include?(pokemon[:id]) && !purified_female_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], purified: 'MF' } : { id: pokemon[:id], name: pokemon[:name], purified: 'MF' }
    }

    shiny_shadow_male_caught = PokemonCaughtTimeline.where(:shiny => true, :shadow => true, :purified => false, :gender => 'M').pluck(:target_evolution_id)
    shiny_shadow_female_caught = PokemonCaughtTimeline.where(:shiny => true, :shadow => true, :purified => false, :gender => 'F').pluck(:target_evolution_id)
    shiny_purified_male_caught = PokemonCaughtTimeline.where(:shiny => true, :shadow => false, :purified => true, :gender => 'M').pluck(:target_evolution_id)
    shiny_purified_female_caught = PokemonCaughtTimeline.where(:shiny => true, :shadow => false, :purified => true, :gender => 'F').pluck(:target_evolution_id)
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shiny_shadow_released.include?(pokemon[:id]) && !shiny_shadow_male_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shiny_shadow: 'M' } : { id: pokemon[:id], name: pokemon[:name], shiny_shadow: 'M' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shiny_shadow_released.include?(pokemon[:id]) && !shiny_shadow_female_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shiny_shadow: 'F' } : { id: pokemon[:id], name: pokemon[:name], shiny_shadow: 'F' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shiny_shadow_released.include?(pokemon[:id]) && !shiny_shadow_male_caught.include?(pokemon[:id]) && !shiny_shadow_female_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shiny_shadow: 'MF' } : { id: pokemon[:id], name: pokemon[:name], shiny_shadow: 'MF' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shiny_shadow_released.include?(pokemon[:id]) && !shiny_purified_male_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shiny_purified: 'M' } : { id: pokemon[:id], name: pokemon[:name], shiny_purified: 'M' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shiny_shadow_released.include?(pokemon[:id]) && !shiny_purified_female_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shiny_purified: 'F' } : { id: pokemon[:id], name: pokemon[:name], shiny_purified: 'F' }
    }
    (pokemons.select { |pokemon| pokemon[:gender_variant] && shiny_shadow_released.include?(pokemon[:id]) && !shiny_purified_male_caught.include?(pokemon[:id]) && !shiny_purified_female_caught.include?(pokemon[:id]) }).each { |pokemon|
      need[pokemon[:id]] = need[pokemon[:id]] ? { **need[pokemon[:id]], shiny_purified: 'MF' } : { id: pokemon[:id], name: pokemon[:name], shiny_purified: 'MF' }
    }

    keys = [:need, :iv, :shiny, :shadow, :purified, :shiny_shadow, :shiny_purified]
    keys.each { |key| need[need.keys[0]][key] = need[need.keys[0]][key] ? need[need.keys[0]][key] : '' }

    needed = []
    need.keys.each { |key| needed.push(need[key]) }

    render :json => conversion(needed)
  end

  def unseen_uncaught
    needed = []
    # Get seen count and total and caught count and total and put them in the arrays first
    # Then grab all unseen, uncaught and ignored
    unseen = []
    uncaught = []
    ignored = []

    while needed.length < unseen.length || needed.length < uncaught.length || needed.length < ignored.length do
      need = {}
      need[:unseen] = unseen[needed.length] ? unseen[needed.length] : ''
      need[:uncaught] = uncaught[needed.length] ? uncaught[needed.length] : ''
      need[:ignored] = ignored[needed.length] ? ignored[needed.length] : ''
      needed.push(need)
    end

    render :json => conversion(needed)
  end

  def raiders
    render :json => conversion([])
  end

  def pvp
    render :json => conversion([])
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
  
  def routes
    render :json => ['needed_pokemon', 'unseen/uncaught_pokemon', 'raiders', 'pvp', 'purchase_stats', 'released_pokemon', 'released_shinies', 'unreleased_shinies']
  end

  def conversion(records)
    return records.empty? ? [] : [records.as_json[0].symbolize_keys.keys, *records]
  end
end
