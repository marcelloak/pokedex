class Api::SeasonTimelinesController < ApplicationController
  def index
    season_timelines = SeasonTimeline.all

    render :json => season_timelines
  end

  def show
    season_timeline = SeasonTimeline.find(params[:id])

    render :json => season_timeline
  end

  def create
    season_timeline = SeasonTimeline.new(season_timeline_params)

    if season_timeline.save
      render :json => season_timeline
    else
      render :json => {
        error: 'Season Timeline was not saved'
      }
    end
  end

  def update
    season_timeline = SeasonTimeline.find(params[:id])

    if season_timeline.update(season_timeline_params)
      render :json => season_timeline
    else
      render :json => {
        error: 'Season Timeline was not updated'
      }
    end
  end

  def destroy
    season_timeline = SeasonTimeline.find(params[:id])
    season_timeline.destroy

    render :json => {
      message: 'Season Timeline was destroyed'
    }
  end

  private
    def season_timeline_params
      params.permit(:start, :end, :name)
    end
end
