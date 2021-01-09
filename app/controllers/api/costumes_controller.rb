class Api::CostumesController < ApplicationController
  def index
    costumes = Costume.all.order(:id)
    costumes = costumes.as_json.map { |costume|
      {
        **costume.symbolize_keys,
        pokemon_id: { id: costume.symbolize_keys[:pokemon_id], name: Pokemon.find(costume.symbolize_keys[:pokemon_id])[:name] }
      }
    }

    render :json => costumes
  end

  def show
    costume = Costume.find(params[:id])

    render :json => costume
  end

  def create
    costume = Costume.new(costume_params)

    if costume.save
      render :json => costume
    else
      render :json => {
        error: 'Costume was not saved'
      }
    end
  end

  def update
    costume = Costume.find(params[:id])

    if costume.update(costume_params)
      render :json => costume
    else
      render :json => {
        error: 'Costume was not updated'
      }
    end
  end

  def destroy
    costume = Costume.find(params[:id])
    costume.destroy

    render :json => {
      message: 'Costume was destroyed'
    }
  end

  private
    def costume_params
      params.permit(:name, :gender_variant, :pokemon_id)
    end
end
