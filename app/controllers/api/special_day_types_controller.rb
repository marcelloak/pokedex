class Api::SpecialDayTypesController < ApplicationController
  def index
    special_day_types = SpecialDayType.all.order(:id)

    render :json => special_day_types
  end

  def show
    special_day_type = SpecialDayType.find(params[:id])

    render :json => special_day_type
  end

  def create
    special_day_type = SpecialDayType.new(special_day_type_params)

    if special_day_type.save
      render :json => special_day_type
    else
      render :json => {
        error: 'Special Day Type was not saved'
      }
    end
  end

  def update
    special_day_type = SpecialDayType.find(params[:id])

    if special_day_type.update(special_day_type_params)
      render :json => special_day_type
    else
      render :json => {
        error: 'Special Day Type was not updated'
      }
    end
  end

  def destroy
    special_day_type = SpecialDayType.find(params[:id])
    special_day_type.destroy

    render :json => {
      message: 'Special Day Type was destroyed'
    }
  end

  private
    def special_day_type_params
      params.permit(:name)
    end
end
