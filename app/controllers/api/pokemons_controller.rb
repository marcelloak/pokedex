class Api::PokemonsController < ApplicationController
  def index
    pokemons = Pokemon.all.order(:id)
    pokemons = pokemons.as_json.map { |pokemon|
      {
        **pokemon.symbolize_keys,
        evolves_from_id: { id: pokemon.symbolize_keys[:evolves_from_id], name: pokemon.symbolize_keys[:evolves_from_id] ? Pokemon.find(pokemon.symbolize_keys[:evolves_from_id])[:name] : pokemon.symbolize_keys[:evolves_from_id] },
        generation_id: { id: pokemon.symbolize_keys[:generation_id], name: Generation.find(pokemon.symbolize_keys[:generation_id])[:name] },
        family_id: { id: pokemon.symbolize_keys[:family_id], name: Family.find(pokemon.symbolize_keys[:family_id])[:name] },
        primary_type_id: { id: pokemon.symbolize_keys[:primary_type_id], name: Type.find(pokemon.symbolize_keys[:primary_type_id])[:icon] },
        secondary_type_id: { id: pokemon.symbolize_keys[:secondary_type_id], name: Type.find(pokemon.symbolize_keys[:secondary_type_id])[:icon] }
      }
    }

    render :json => pokemons
  end

  def show
    pokemon = Pokemon.find(params[:id])

    render :json => pokemon
  end

  def create
    pokemon = Pokemon.new(pokemon_params)

    if pokemon.save
      render :json => pokemon
    else
      render :json => {
        error: 'Pokemon was not saved'
      }
    end
  end

  def update
    pokemon = Pokemon.find(params[:id])

    if pokemon.update(pokemon_params)
      render :json => pokemon
    else
      render :json => {
        error: 'Pokemon was not updated'
      }
    end
  end

  def destroy
    pokemon = Pokemon.find(params[:id])
    pokemon.destroy

    render :json => {
      message: 'Pokemon was destroyed'
    }
  end

  private
    def pokemon_params
      params.permit(:name, :number, :attack, :defence, :stamina, :buddy_distance, :evolve_candy, :trade_discount, :evolve_requirement, :gender_variant, :gendered, :legendary, :mythical, :region, :evolves_from_id, :generation_id, :family_id, :primary_type_id, :secondary_type_id)
    end
end
