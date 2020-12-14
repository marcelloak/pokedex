class Api::EventPokemonsController < ApplicationController
  def index
    event_pokemons = EventPokemon.all

    render :json => event_pokemons
  end

  def show
    event_pokemon = EventPokemon.find(params[:id])

    render :json => event_pokemon
  end

  def create
    event_pokemon = EventPokemon.new(event_pokemon_params)

    if event_pokemon.save
      render :json => event_pokemon
    else
      render :json => {
        error: 'Event Pokemon was not saved'
      }
    end
  end

  def update
    event_pokemon = EventPokemon.find(params[:id])

    if event_pokemon.update(event_pokemon_params)
      render :json => event_pokemon
    else
      render :json => {
        error: 'Event Pokemon was not updated'
      }
    end
  end

  def destroy
    event_pokemon = EventPokemon.find(params[:id])
    event_pokemon.destroy

    render :json => {
      message: 'Event Pokemon was destroyed'
    }
  end

  private
    def event_pokemon_params
      params.permit(:id, :event_timeline_id)
    end
end
