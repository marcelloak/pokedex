class Api::ShadowTimelinesController < ApplicationController
  def index
    shadow_timelines = ShadowTimeline.all.order(:id)

    render :json => shadow_timelines
  end

  def show
    shadow_timeline = ShadowTimeline.find(params[:id])

    render :json => shadow_timeline
  end

  def create
    shadow_timeline = ShadowTimeline.new(shadow_timeline_params)

    if shadow_timeline.save
      render :json => shadow_timeline
    else
      render :json => {
        error: 'Shadow Timeline was not saved'
      }
    end
  end

  def update
    shadow_timeline = ShadowTimeline.find(params[:id])

    if shadow_timeline.update(shadow_timeline_params)
      render :json => shadow_timeline
    else
      render :json => {
        error: 'Shadow Timeline was not updated'
      }
    end
  end

  def destroy
    shadow_timeline = ShadowTimeline.find(params[:id])
    shadow_timeline.destroy

    render :json => {
      message: 'Shadow Timeline was destroyed'
    }
  end

  private
    def shadow_timeline_params
      params.permit(:released, :available, :ignored, :pokemon_id)
    end
end
