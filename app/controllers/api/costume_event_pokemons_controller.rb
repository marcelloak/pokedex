class Api::CostumeEventPokemonsController < ApplicationController
  def index
    costume_event_pokemons = CostumeEventPokemon.all.order(:id)
    costume_event_pokemons = costume_event_pokemons.as_json.map { |costume_event_pokemon|
      {
        **costume_event_pokemon.symbolize_keys,
        costume_id: { id: costume_event_pokemon.symbolize_keys[:costume_id], name: "#{Costume.find(costume_event_pokemon.symbolize_keys[:costume_id])[:name]} (#{Pokemon.find(Costume.find(costume_event_pokemon.symbolize_keys[:costume_id])[:pokemon_id])[:name]})" },
        event_timeline_id: { id: costume_event_pokemon.symbolize_keys[:event_timeline_id], name: EventTimeline.find(costume_event_pokemon.symbolize_keys[:event_timeline_id])[:name] }
      }
    }

    render :json => costume_event_pokemons
  end

  def show
    costume_event_pokemon = CostumeEventPokemon.find(params[:id])

    render :json => costume_event_pokemon
  end

  def create
    costume_event_pokemon = CostumeEventPokemon.new(costume_event_pokemon_params)

    if costume_event_pokemon.save
      render :json => costume_event_pokemon
    else
      render :json => {
        error: 'Costume Event Pokemon was not saved'
      }
    end
  end

  def update
    costume_event_pokemon = CostumeEventPokemon.find(params[:id])

    if costume_event_pokemon.update(costume_event_pokemon_params)
      render :json => costume_event_pokemon
    else
      render :json => {
        error: 'Costume Event Pokemon was not updated'
      }
    end
  end

  def destroy
    costume_event_pokemon = CostumeEventPokemon.find(params[:id])
    costume_event_pokemon.destroy

    render :json => {
      message: 'Costume Event Pokemon was destroyed'
    }
  end

  private
    def costume_event_pokemon_params
      params.permit(:costume_id, :event_timeline_id)
    end
end
