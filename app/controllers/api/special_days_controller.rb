class Api::SpecialDaysController < ApplicationController
  def index
    special_days = SpecialDay.all.order(:id)
    special_days = special_days.as_json.map { |special_day|
      {
        **special_day.symbolize_keys,
        pokemon_id: { id: special_day.symbolize_keys[:pokemon_id], name: Pokemon.find(special_day.symbolize_keys[:pokemon_id])[:name] },
        special_day_type_id: { id: special_day.symbolize_keys[:special_day_type_id], name: SpecialDayType.find(special_day.symbolize_keys[:special_day_type_id])[:name] }
      }
    }

    render :json => special_days
  end

  def show
    special_day = SpecialDay.find(params[:id])

    render :json => special_day
  end

  def create
    special_day = SpecialDay.new(special_day_params)

    if special_day.save
      render :json => special_day
    else
      render :json => {
        error: 'Special Day was not saved'
      }
    end
  end

  def update
    special_day = SpecialDay.find(params[:id])

    if special_day.update(special_day_params)
      render :json => special_day
    else
      render :json => {
        error: 'Special Day was not updated'
      }
    end
  end

  def destroy
    special_day = SpecialDay.find(params[:id])
    special_day.destroy

    render :json => {
      message: 'Special Day was destroyed'
    }
  end

  private
    def special_day_params
      params.permit(:date, :pokemon_id, :special_day_type_id)
    end
end
