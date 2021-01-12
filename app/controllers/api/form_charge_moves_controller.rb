class Api::FormChargeMovesController < ApplicationController
  def index
    form_charge_moves = FormChargeMove.all.order(:id)
    form_charge_moves = form_charge_moves.as_json.map { |form_charge_move|
      {
        **form_charge_move.symbolize_keys,
        form_id: { id: form_charge_move.symbolize_keys[:form_id], name: Form.find(form_charge_move.symbolize_keys[:form_id])[:name] },
        charge_move_id: { id: form_charge_move.symbolize_keys[:charge_move_id], name: ChargeMove.find(form_charge_move.symbolize_keys[:charge_move_id])[:name] }
      }
    }

    render :json => form_charge_moves
  end

  def show
    form_charge_move = FormChargeMove.find(params[:id])

    render :json => form_charge_move
  end

  def create
    form_charge_move = FormChargeMove.new(form_charge_move_params)

    if form_charge_move.save
      render :json => form_charge_move
    else
      render :json => {
        error: 'Form Charge Move was not saved'
      }
    end
  end

  def update
    form_charge_move = FormChargeMove.find(params[:id])

    if form_charge_move.update(form_charge_move_params)
      render :json => form_charge_move
    else
      render :json => {
        error: 'Form Charge Move was not updated'
      }
    end
  end

  def destroy
    form_charge_move = FormChargeMove.find(params[:id])
    form_charge_move.destroy

    render :json => {
      message: 'Form Charge Move was destroyed'
    }
  end

  private
    def form_charge_move_params
      params.permit(:form_id, :charge_move_id, :legacy, :elite)
    end
end
