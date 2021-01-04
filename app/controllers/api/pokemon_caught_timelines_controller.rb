class Api::PokemonCaughtTimelinesController < ApplicationController
  def index
    pokemon_caught_timelines = PokemonCaughtTimeline.all.order(:id)

    render :json => pokemon_caught_timelines
  end

  def show
    pokemon_caught_timeline = PokemonCaughtTimeline.find(params[:id])

    render :json => pokemon_caught_timeline
  end

  def create
    pokemon_caught_timeline = PokemonCaughtTimeline.new(pokemon_caught_timeline_params)

    if pokemon_caught_timeline.save
      render :json => pokemon_caught_timeline
    else
      render :json => {
        error: 'Pokemon Caught Timeline was not saved'
      }
    end
  end

  def update
    pokemon_caught_timeline = PokemonCaughtTimeline.find(params[:id])

    if pokemon_caught_timeline.update(pokemon_caught_timeline_params)
      render :json => pokemon_caught_timeline
    else
      render :json => {
        error: 'Pokemon Caught Timeline was not updated'
      }
    end
  end

  def destroy
    pokemon_caught_timeline = PokemonCaughtTimeline.find(params[:id])
    pokemon_caught_timeline.destroy

    render :json => {
      message: 'Pokemon Caught Timeline was destroyed'
    }
  end

  private
    def pokemon_caught_timeline_params
      params.permit(:caught, :attack, :defence, :stamina, :current_level, :target_level, :gender, :shadow, :purified, :shiny, :lucky, :charge_move_unlocked, :transferred, :current_evolution_id, :target_evolution_id, :fast_move_id, :first_charge_move_id, :second_charge_move_id, :original_owner_id, :current_owner_id)
    end
end
