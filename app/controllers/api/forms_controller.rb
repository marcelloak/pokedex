class Api::FormsController < ApplicationController
  def index
    forms = Form.all.order(:id)

    render :json => forms
  end

  def show
    form = Form.find(params[:id])

    render :json => form
  end

  def create
    form = Form.new(form_params)

    if form.save
      render :json => form
    else
      render :json => {
        error: 'Form was not saved'
      }
    end
  end

  def update
    form = Form.find(params[:id])

    if form.update(form_params)
      render :json => form
    else
      render :json => {
        error: 'Form was not updated'
      }
    end
  end

  def destroy
    form = Form.find(params[:id])
    form.destroy

    render :json => {
      message: 'Form was destroyed'
    }
  end

  private
    def form_params
      params.permit(:name, :attack, :defence, :stamina, :pokemon_id, :evolves_from_id, :primary_type_id, :secondary_type_id)
    end
end
