class Api::CostumeSpecialDaysController < ApplicationController
  def index
    costume_special_days = CostumeSpecialDay.all

    render :json => costume_special_days
  end

  def show
    costume_special_day = CostumeSpecialDay.find(params[:id])

    render :json => costume_special_day
  end

  def create
    costume_special_day = CostumeSpecialDay.new(costume_special_day_params)

    if costume_special_day.save
      render :json => costume_special_day
    else
      render :json => {
        error: 'Costume Special Day was not saved'
      }
    end
  end

  def update
    costume_special_day = CostumeSpecialDay.find(params[:id])

    if costume_special_day.update(costume_special_day_params)
      render :json => costume_special_day
    else
      render :json => {
        error: 'Costume Special Day was not updated'
      }
    end
  end

  def destroy
    costume_special_day = CostumeSpecialDay.find(params[:id])
    costume_special_day.destroy

    render :json => {
      message: 'Costume Special Day was destroyed'
    }
  end

  private
    def costume_special_day_params
      params.permit(:date, :pokemon_id, :costume_special_day_type_id)
    end
end