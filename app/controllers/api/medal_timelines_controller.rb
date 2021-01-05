class Api::MedalTimelinesController < ApplicationController
  def index
    medal_timelines = MedalTimeline.all.order(:id)
    medal_timelines = medal_timelines.as_json.map { |medal_timeline|
      {
        **medal_timeline.symbolize_keys,
        medal_id: { id: medal_timeline.symbolize_keys[:medal_id], name: Pokemon.find(medal_timeline.symbolize_keys[:medal_id])[:name] }
      }
    }

    render :json => medal_timelines
  end

  def show
    medal_timeline = MedalTimeline.find(params[:id])

    render :json => medal_timeline
  end

  def create
    medal_timeline = MedalTimeline.new(medal_timeline_params)

    if medal_timeline.save
      render :json => medal_timeline
    else
      render :json => {
        error: 'Medal Timeline was not saved'
      }
    end
  end

  def update
    medal_timeline = MedalTimeline.find(params[:id])

    if medal_timeline.update(medal_timeline_params)
      render :json => medal_timeline
    else
      render :json => {
        error: 'Medal Timeline was not updated'
      }
    end
  end

  def destroy
    medal_timeline = MedalTimeline.find(params[:id])
    medal_timeline.destroy

    render :json => {
      message: 'Medal Timeline was destroyed'
    }
  end

  private
    def medal_timeline_params
      params.permit(:released, :medal_id)
    end
end
