class Api::ShinyFormTimelinesController < ApplicationController
  def index
    shiny_form_timelines = ShinyFormTimeline.all.order(:id)
    shiny_form_timelines = shiny_form_timelines.as_json.map { |shiny_form_timeline|
      {
        **shiny_form_timeline.symbolize_keys,
        form_id: { id: shiny_form_timeline.symbolize_keys[:form_id], name: "#{Form.find(shiny_form_timeline.symbolize_keys[:form_id])[:name]} (#{Pokemon.find(Form.find(shiny_form_timeline.symbolize_keys[:form_id])[:pokemon_id])[:name]})" }
      }
    }

    render :json => shiny_form_timelines
  end

  def show
    shiny_form_timeline = ShinyFormTimeline.find(params[:id])

    render :json => shiny_form_timeline
  end

  def create
    shiny_form_timeline = ShinyFormTimeline.new(shiny_form_timeline_params)

    if shiny_form_timeline.save
      render :json => shiny_form_timeline
    else
      render :json => {
        error: 'Shiny Form Timeline was not saved'
      }
    end
  end

  def update
    shiny_form_timeline = ShinyFormTimeline.find(params[:id])

    if shiny_form_timeline.update(shiny_form_timeline_params)
      render :json => shiny_form_timeline
    else
      render :json => {
        error: 'Shiny Form Timeline was not updated'
      }
    end
  end

  def destroy
    shiny_form_timeline = ShinyFormTimeline.find(params[:id])
    shiny_form_timeline.destroy

    render :json => {
      message: 'Shiny Form Timeline was destroyed'
    }
  end

  private
    def shiny_form_timeline_params
      params.permit(:released, :available, :ignored, :form_id)
    end
end
