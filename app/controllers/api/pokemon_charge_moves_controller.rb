class Api::PokemonChargeMovesController < ApplicationController
  def index
    pokemon_charge_moves = PokemonChargeMove.all.order(:id)
    pokemon_charge_moves = pokemon_charge_moves.as_json.map { |pokemon_charge_move|
      {
        **pokemon_charge_move.symbolize_keys,
        pokemon_id: { id: pokemon_charge_move.symbolize_keys[:pokemon_id], name: Pokemon.find(pokemon_charge_move.symbolize_keys[:pokemon_id])[:name] },
        charge_move_id: { id: pokemon_charge_move.symbolize_keys[:charge_move_id], name: ChargeMove.find(pokemon_charge_move.symbolize_keys[:charge_move_id])[:name] }
      }
    }

    render :json => pokemon_charge_moves
  end

  def show
    pokemon_charge_move = PokemonChargeMove.find(params[:id])

    render :json => pokemon_charge_move
  end

  def create
    pokemon_charge_move = PokemonChargeMove.new(pokemon_charge_move_params)

    if pokemon_charge_move.save
      render :json => pokemon_charge_move
    else
      render :json => {
        error: 'Pokemon Charge Move was not saved'
      }
    end
  end

  def update
    pokemon_charge_move = PokemonChargeMove.find(params[:id])

    if pokemon_charge_move.update(pokemon_charge_move_params)
      render :json => pokemon_charge_move
    else
      render :json => {
        error: 'Pokemon Charge Move was not updated'
      }
    end
  end

  def destroy
    pokemon_charge_move = PokemonChargeMove.find(params[:id])
    pokemon_charge_move.destroy

    render :json => {
      message: 'Pokemon Charge Move was destroyed'
    }
  end

  private
    def pokemon_charge_move_params
      params.permit(:pokemon_id, :charge_move_id, :legacy, :elite)
    end
end
