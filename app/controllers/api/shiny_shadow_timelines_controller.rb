class Api::ShinyShadowTimelinesController < ApplicationController
  def index
    shiny_shadow_timelines = ShinyShadowTimeline.all.order(:id)

    render :json => shiny_shadow_timelines
  end

  def show
    shiny_shadow_timeline = ShinyShadowTimeline.find(params[:id])

    render :json => shiny_shadow_timeline
  end

  def create
    shiny_shadow_timeline = ShinyShadowTimeline.new(shiny_shadow_timeline_params)

    if shiny_shadow_timeline.save
      render :json => shiny_shadow_timeline
    else
      render :json => {
        error: 'Shiny Shadow Timeline was not saved'
      }
    end
  end

  def update
    shiny_shadow_timeline = ShinyShadowTimeline.find(params[:id])

    if shiny_shadow_timeline.update(shiny_shadow_timeline_params)
      render :json => shiny_shadow_timeline
    else
      render :json => {
        error: 'Shiny Shadow Timeline was not updated'
      }
    end
  end

  def destroy
    shiny_shadow_timeline = ShinyShadowTimeline.find(params[:id])
    shiny_shadow_timeline.destroy

    render :json => {
      message: 'Shiny Shadow Timeline was destroyed'
    }
  end

  private
    def shiny_shadow_timeline_params
      params.permit(:released, :available, :ignored, :pokemon_id)
    end
end
