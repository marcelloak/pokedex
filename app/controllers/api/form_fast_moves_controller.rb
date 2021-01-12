class Api::FormFastMovesController < ApplicationController
  def index
    form_fast_moves = FormFastMove.all.order(:id)
    form_fast_moves = form_fast_moves.as_json.map { |form_fast_move|
      {
        **form_fast_move.symbolize_keys,
        form_id: { id: form_fast_move.symbolize_keys[:form_id], name: Form.find(form_fast_move.symbolize_keys[:form_id])[:name] },
        fast_move_id: { id: form_fast_move.symbolize_keys[:fast_move_id], name: FastMove.find(form_fast_move.symbolize_keys[:fast_move_id])[:name] }
      }
    }

    render :json => form_fast_moves
  end

  def show
    form_fast_move = FormFastMove.find(params[:id])

    render :json => form_fast_move
  end

  def create
    form_fast_move = FormFastMove.new(form_fast_move_params)

    if form_fast_move.save
      render :json => form_fast_move
    else
      render :json => {
        error: 'Form Fast Move was not saved'
      }
    end
  end

  def update
    form_fast_move = FormFastMove.find(params[:id])

    if form_fast_move.update(form_fast_move_params)
      render :json => form_fast_move
    else
      render :json => {
        error: 'Form Fast Move was not updated'
      }
    end
  end

  def destroy
    form_fast_move = FormFastMove.find(params[:id])
    form_fast_move.destroy

    render :json => {
      message: 'Form Fast Move was destroyed'
    }
  end

  private
    def form_fast_move_params
      params.permit(:form_id, :fast_move_id, :legacy, :elite)
    end
end
