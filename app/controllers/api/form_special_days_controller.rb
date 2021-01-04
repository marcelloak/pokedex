class Api::FormSpecialDaysController < ApplicationController
  def index
    form_special_days = FormSpecialDay.all.order(:id)

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
      params.permit(:date, :pokemon_id, :form_special_day_type_id)
    end
end
