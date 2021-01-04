class Api::CostumesController < ApplicationController
  def index
    costumes = Costume.all.order(:id)

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
      params.permit(:name, :attack, :defence, :stamina, :pokemon_id)
    end
end
