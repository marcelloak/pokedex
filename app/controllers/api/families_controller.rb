class Api::FamiliesController < ApplicationController
  def index
    families = Family.all.order(:id)
    families = families.as_json.map { |family|
      {
        **family.symbolize_keys,
        generation_id: { id: family.symbolize_keys[:generation_id], name: Generation.find(family.symbolize_keys[:generation_id])[:name] },
      }
    }

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

  def foreign_keys
    families = Family.all.order(:id)

    render :json => families
  end

  private
    def family_params
      params.permit(:name, :buddy_distance, :generation_id)
    end
end
