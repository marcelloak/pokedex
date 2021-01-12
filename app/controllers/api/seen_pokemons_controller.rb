class Api::SeenPokemonsController < ApplicationController
  def index
    seen_pokemons = SeenPokemon.all.order(:id)
    seen_pokemons = seen_pokemons.as_json.map { |seen_pokemon|
      {
        **seen_pokemon.symbolize_keys,
        pokemon_id: { id: seen_pokemon.symbolize_keys[:pokemon_id], name: Pokemon.find(seen_pokemon.symbolize_keys[:pokemon_id])[:name] }
      }
    }

    render :json => seen_pokemons
  end

  def show
    seen_pokemon = SeenPokemon.find(params[:id])

    render :json => seen_pokemon
  end

  def create
    seen_pokemon = SeenPokemon.new(seen_pokemon_params)

    if seen_pokemon.save
      render :json => seen_pokemon
    else
      render :json => {
        error: 'Seen Pokemon was not saved'
      }
    end
  end

  def update
    seen_pokemon = SeenPokemon.find(params[:id])

    if seen_pokemon.update(seen_pokemon_params)
      render :json => seen_pokemon
    else
      render :json => {
        error: 'Seen Pokemon was not updated'
      }
    end
  end

  def destroy
    seen_pokemon = SeenPokemon.find(params[:id])
    seen_pokemon.destroy

    render :json => {
      message: 'Seen Pokemon was destroyed'
    }
  end

  private
    def seen_pokemon_params
      params.permit(:lucky, :gender, :pokemon_id)
    end
end
