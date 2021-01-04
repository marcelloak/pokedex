class Api::TypesController < ApplicationController
  def index
    types = Type.all.order(:id)

    render :json => types
  end

  def show
    type = Type.find(params[:id])

    render :json => type
  end

  def create
    type = Type.new(type_params)

    if type.save
      render :json => type
    else
      render :json => {
        error: 'Type was not saved'
      }
    end
  end

  def update
    type = Type.find(params[:id])

    if type.update(type_params)
      render :json => type
    else
      render :json => {
        error: 'Type was not updated'
      }
    end
  end

  def destroy
    type = Type.find(params[:id])
    type.destroy

    render :json => {
      message: 'Type was destroyed'
    }
  end

  private
    def type_params
      params.permit(:name, :icon)
    end
end
