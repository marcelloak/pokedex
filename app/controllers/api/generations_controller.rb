class Api::GenerationsController < ApplicationController
  def index
    generations = Generation.all.order(:id)

    render :json => generations
  end

  def show
    generation = Generation.find(params[:id])

    render :json => generation
  end

  def create
    generation = Generation.new(generation_params)

    if generation.save
      render :json => generation
    else
      render :json => {
        error: 'Generation was not saved'
      }
    end
  end

  def update
    generation = Generation.find(params[:id])

    if generation.update(generation_params)
      render :json => generation
    else
      render :json => {
        error: 'Generation was not updated'
      }
    end
  end

  def destroy
    generation = Generation.find(params[:id])
    generation.destroy

    render :json => {
      message: 'Generation was destroyed'
    }
  end

  private
    def generation_params
      params.permit(:name)
    end
end
