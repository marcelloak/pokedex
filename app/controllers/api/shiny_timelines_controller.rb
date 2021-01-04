class Api::ShinyTimelinesController < ApplicationController
  def index
    shiny_timelines = ShinyTimeline.all.order(:id)

    render :json => shiny_timelines
  end

  def show
    shiny_timeline = ShinyTimeline.find(params[:id])

    render :json => shiny_timeline
  end

  def create
    shiny_timeline = ShinyTimeline.new(shiny_timeline_params)

    if shiny_timeline.save
      render :json => shiny_timeline
    else
      render :json => {
        error: 'Shiny Timeline was not saved'
      }
    end
  end

  def update
    shiny_timeline = ShinyTimeline.find(params[:id])

    if shiny_timeline.update(shiny_timeline_params)
      render :json => shiny_timeline
    else
      render :json => {
        error: 'Shiny Timeline was not updated'
      }
    end
  end

  def destroy
    shiny_timeline = ShinyTimeline.find(params[:id])
    shiny_timeline.destroy

    render :json => {
      message: 'Shiny Timeline was destroyed'
    }
  end

  private
    def shiny_timeline_params
      params.permit(:released, :available, :ignored, :pokemon_id)
    end
end
