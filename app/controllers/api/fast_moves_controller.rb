class Api::FastMovesController < ApplicationController
  def index
    fast_moves = FastMove.all

    render :json => fast_moves
  end

  def show
    fast_move = FastMove.find(params[:id])

    render :json => fast_move
  end

  def create
    fast_move = FastMove.new(fast_move_params)

    if fast_move.save
      render :json => fast_move
    else
      render :json => {
        error: 'Fast Move was not saved'
      }
    end
  end

  def update
    fast_move = FastMove.find(params[:id])

    if fast_move.update(fast_move_params)
      render :json => fast_move
    else
      render :json => {
        error: 'Fast Move was not updated'
      }
    end
  end

  def destroy
    fast_move = FastMove.find(params[:id])
    fast_move.destroy

    render :json => {
      message: 'Fast Move was destroyed'
    }
  end

  private
    def fast_move_params
      params.permit(:name, :turns, :damage, :energy, :pve_damage, :pve_energy, :pve_seconds, :type_id)
    end
end
