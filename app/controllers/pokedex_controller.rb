class PokedexController < ApplicationController
  def released_pokemon
    released = PokemonTimeline.all.pluck(:pokemon_id)
    pokemons = Pokemon.all.select { |pokemon| released.include?(pokemon[:id])}
    pokemons = pokemons.as_json.map { |pokemon|
      {
        **pokemon.symbolize_keys,
        evolves_from_id: { id: pokemon.symbolize_keys[:evolves_from_id], name: pokemon.symbolize_keys[:evolves_from_id] ? Pokemon.find(pokemon.symbolize_keys[:evolves_from_id])[:name] : pokemon.symbolize_keys[:evolves_from_id] },
        generation_id: { id: pokemon.symbolize_keys[:generation_id], name: Generation.find(pokemon.symbolize_keys[:generation_id])[:name] },
        family_id: { id: pokemon.symbolize_keys[:family_id], name: Family.find(pokemon.symbolize_keys[:family_id])[:name] },
        primary_type_id: { id: pokemon.symbolize_keys[:primary_type_id], name: Type.find(pokemon.symbolize_keys[:primary_type_id])[:icon] },
        secondary_type_id: { id: pokemon.symbolize_keys[:secondary_type_id], name: pokemon.symbolize_keys[:secondary_type_id] ? Type.find(pokemon.symbolize_keys[:secondary_type_id])[:icon] : pokemon.symbolize_keys[:secondary_type_id] }
      }
    }
    render :json => conversion(pokemons)
  end
  
  def released_shinies
    released = ShinyTimeline.all.pluck(:pokemon_id)
    shinies = Pokemon.all.select { |pokemon| released.include?(pokemon[:id])}
    render :json => conversion(shinies)
  end
  
  def routes
    render :json => ['released_pokemon', 'released_shinies']
  end

  def conversion(records)
    return records.empty? ? [] : [records.as_json[0].symbolize_keys.keys, *records]
  end
end
