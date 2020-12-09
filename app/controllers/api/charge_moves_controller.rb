class Api::ChargeMovesController < ApplicationController
  def index
    charge_moves = ChargeMove.all

    render :json => charge_moves
  end

  def show
    charge_move = ChargeMove.find(params[:id])

    render :json => charge_move
  end

  def create
    charge_move = ChargeMove.new(charge_move_params)

    if charge_move.save
      render :json => charge_move
    else
      render :json => {
        error: 'Charge Move was not saved'
      }
    end
  end

  def update
    charge_move = ChargeMove.find(params[:id])

    if charge_move.update(charge_move_params)
      render :json => charge_move
    else
      render :json => {
        error: 'Charge Move was not updated'
      }
    end
  end

  def destroy
    charge_move = ChargeMove.find(params[:id])
    charge_move.destroy

    render :json => {
      message: 'Charge Move was destroyed'
    }
  end

  private
    def charge_move_params
      params.permit(:name, :damage, :energy, :effect, :pve_damage, :pve_energy, :pve_seconds, :type_id)
    end
end
