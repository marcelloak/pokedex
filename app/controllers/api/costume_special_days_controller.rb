class Api::CostumeSpecialDaysController < ApplicationController
  def index
    costume_special_days = CostumeSpecialDay.all.order(:id)
    costume_special_days = costume_special_days.as_json.map { |costume_special_day|
      {
        **costume_special_day.symbolize_keys,
        costume_id: { id: costume_special_day.symbolize_keys[:costume_id], name: "#{Costume.find(costume_special_day.symbolize_keys[:costume_id])[:name]} (#{Pokemon.find(Costume.find(costume_special_day.symbolize_keys[:costume_id])[:pokemon_id])[:name]})" },
        special_day_type_id: { id: costume_special_day.symbolize_keys[:special_day_type_id], name: SpecialDayType.find(costume_special_day.symbolize_keys[:special_day_type_id])[:name] }
      }
    }

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
      params.permit(:date, :costume_id, :special_day_type_id)
    end
end
