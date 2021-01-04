class Api::FamiliesController < ApplicationController
  def index
    families = Family.all.order(:id)

    render :json => families
  end

  def show
    family = Family.find(params[:id])

    render :json => family
  end

  def create
    family = Family.new(family_params)

    if family.save
      render :json => family
    else
      render :json => {
        error: 'Family was not saved'
      }
    end
  end

  def update
    family = Family.find(params[:id])

    if family.update(family_params)
      render :json => family
    else
      render :json => {
        error: 'Family was not updated'
      }
    end
  end

  def destroy
    family = Family.find(params[:id])
    family.destroy

    render :json => {
      message: 'Family was destroyed'
    }
  end

  private
    def family_params
      params.permit(:name)
    end
end
