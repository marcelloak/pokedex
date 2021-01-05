class Api::PokemonFastMovesController < ApplicationController
  def index
    pokemon_fast_moves = PokemonFastMove.all.order(:id)
    pokemon_fast_moves = pokemon_fast_moves.as_json.map { |pokemon_fast_move|
      {
        **pokemon_fast_move.symbolize_keys,
        pokemon_id: { id: pokemon_fast_move.symbolize_keys[:pokemon_id], name: Pokemon.find(pokemon_fast_move.symbolize_keys[:pokemon_id])[:name] },
        fast_move_id: { id: pokemon_fast_move.symbolize_keys[:fast_move_id], name: FastMove.find(pokemon_fast_move.symbolize_keys[:fast_move_id])[:name] }
      }
    }

    render :json => pokemon_fast_moves
  end

  def show
    pokemon_fast_move = PokemonFastMove.find(params[:id])

    render :json => pokemon_fast_move
  end

  def create
    pokemon_fast_move = PokemonFastMove.new(pokemon_fast_move_params)

    if pokemon_fast_move.save
      render :json => pokemon_fast_move
    else
      render :json => {
        error: 'Pokemon Fast Move was not saved'
      }
    end
  end

  def update
    pokemon_fast_move = PokemonFastMove.find(params[:id])

    if pokemon_fast_move.update(pokemon_fast_move_params)
      render :json => pokemon_fast_move
    else
      render :json => {
        error: 'Pokemon Fast Move was not updated'
      }
    end
  end

  def destroy
    pokemon_fast_move = PokemonFastMove.find(params[:id])
    pokemon_fast_move.destroy

    render :json => {
      message: 'Pokemon Fast Move was destroyed'
    }
  end

  private
    def pokemon_fast_move_params
      params.permit(:pokemon_id, :fast_move_id, :legacy, :elite)
    end
end
