class Api::FormsController < ApplicationController
  def index
    forms = Form.all.order(:id)
    forms = forms.as_json.map { |form|
      {
        **form.symbolize_keys,
        pokemon_id: { id: form.symbolize_keys[:pokemon_id], name: Pokemon.find(form.symbolize_keys[:pokemon_id])[:name] },
        evolves_from_id: { id: form.symbolize_keys[:evolves_from_id], name: form.symbolize_keys[:evolves_from_id] ? Pokemon.find(form.symbolize_keys[:evolves_from_id])[:name] : form.symbolize_keys[:evolves_from_id] },
        primary_type_id: { id: form.symbolize_keys[:primary_type_id], name: Type.find(form.symbolize_keys[:primary_type_id])[:icon] },
        secondary_type_id: { id: form.symbolize_keys[:secondary_type_id], name: form.symbolize_keys[:secondary_type_id] ? Type.find(form.symbolize_keys[:secondary_type_id])[:icon] : form.symbolize_keys[:secondary_type_id] }
      }
    }

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
      params.permit(:name, :attack, :defence, :stamina, :pokemon_id, :evolves_from_id, :primary_type_id, :secondary_type_id, :default)
    end
end
