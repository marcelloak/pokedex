class Api::PokemonTimelinesController < ApplicationController
  def index
    pokemon_timelines = PokemonTimeline.all

    render :json => pokemon_timelines
  end

  def show
    pokemon_timeline = PokemonTimeline.find(params[:id])

    render :json => pokemon_timeline
  end

  def create
    pokemon_timeline = PokemonTimeline.new(pokemon_timeline_params)

    if pokemon_timeline.save
      render :json => pokemon_timeline
    else
      render :json => {
        error: 'Pokemon Timeline was not saved'
      }
    end
  end

  def update
    pokemon_timeline = PokemonTimeline.find(params[:id])

    if pokemon_timeline.update(pokemon_timeline_params)
      render :json => pokemon_timeline
    else
      render :json => {
        error: 'Pokemon Timeline was not updated'
      }
    end
  end

  def destroy
    pokemon_timeline = PokemonTimeline.find(params[:id])
    pokemon_timeline.destroy

    render :json => {
      message: 'Pokemon Timeline was destroyed'
    }
  end

  private
    def pokemon_timeline_params
      params.permit(:released, :available, :ignored, :pokemon_id)
    end
end
