class Api::FormSpecialDaysController < ApplicationController
  def index
    form_special_days = FormSpecialDay.all.order(:id)
    form_special_days = form_special_days.as_json.map { |form_special_day|
      {
        **form_special_day.symbolize_keys,
        form_id: { id: form_special_day.symbolize_keys[:form_id], name: "#{Form.find(form_special_day.symbolize_keys[:form_id])[:name]} (#{Pokemon.find(Form.find(form_special_day.symbolize_keys[:form_id])[:pokemon_id])[:name]})" },
        special_day_type_id: { id: form_special_day.symbolize_keys[:special_day_type_id], name: SpecialDayType.find(form_special_day.symbolize_keys[:special_day_type_id])[:name] }
      }
    }

    render :json => form_special_days
  end

  def show
    form_special_day = FormSpecialDay.find(params[:id])

    render :json => form_special_day
  end

  def create
    form_special_day = FormSpecialDay.new(form_special_day_params)

    if form_special_day.save
      render :json => form_special_day
    else
      render :json => {
        error: 'Form Special Day was not saved'
      }
    end
  end

  def update
    form_special_day = FormSpecialDay.find(params[:id])

    if form_special_day.update(form_special_day_params)
      render :json => form_special_day
    else
      render :json => {
        error: 'Form Special Day was not updated'
      }
    end
  end

  def destroy
    form_special_day = FormSpecialDay.find(params[:id])
    form_special_day.destroy

    render :json => {
      message: 'Form Special Day was destroyed'
    }
  end

  private
    def form_special_day_params
      params.permit(:date, :form_id, :special_day_type_id)
    end
end
