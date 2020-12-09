class Api::PokemonLevelsController < ApplicationController
  def index
    pokemon_levels = PokemonLevel.all

    render :json => pokemon_levels
  end

  def show
    pokemon_level = PokemonLevel.find(params[:id])

    render :json => pokemon_level
  end

  def create
    pokemon_level = PokemonLevel.new(pokemon_level_params)

    if pokemon_level.save
      render :json => pokemon_level
    else
      render :json => {
        error: 'Pokemon Level was not saved'
      }
    end
  end

  def update
    pokemon_level = PokemonLevel.find(params[:id])

    if pokemon_level.update(pokemon_level_params)
      render :json => pokemon_level
    else
      render :json => {
        error: 'Pokemon Level was not updated'
      }
    end
  end

  def destroy
    pokemon_level = PokemonLevel.find(params[:id])
    pokemon_level.destroy

    render :json => {
      message: 'Pokemon Level was destroyed'
    }
  end

  private
    def pokemon_level_params
      params.permit(:level, :stardust, :candy, :candy_xl, :cp_multiplier)
    end
end
