class Api::FormEventPokemonsController < ApplicationController
  def index
    form_event_pokemons = FormEventPokemon.all

    render :json => form_event_pokemons
  end

  def show
    form_event_pokemon = FormEventPokemon.find(params[:id])

    render :json => form_event_pokemon
  end

  def create
    form_event_pokemon = FormEventPokemon.new(form_event_pokemon_params)

    if form_event_pokemon.save
      render :json => form_event_pokemon
    else
      render :json => {
        error: 'Form Event Pokemon was not saved'
      }
    end
  end

  def update
    form_event_pokemon = FormEventPokemon.find(params[:id])

    if form_event_pokemon.update(form_event_pokemon_params)
      render :json => form_event_pokemon
    else
      render :json => {
        error: 'Form Event Pokemon was not updated'
      }
    end
  end

  def destroy
    form_event_pokemon = FormEventPokemon.find(params[:id])
    form_event_pokemon.destroy

    render :json => {
      message: 'Form Event Pokemon was destroyed'
    }
  end

  private
    def form_event_pokemon_params
      params.permit(:form_id, :event_timeline_id)
    end
end
