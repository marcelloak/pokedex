class Api::SpecialLeagueTimelinesController < ApplicationController
  def index
    special_league_timelines = SpecialLeagueTimeline.all.order(:id)

    render :json => special_league_timelines
  end

  def show
    special_league_timeline = SpecialLeagueTimeline.find(params[:id])

    render :json => special_league_timeline
  end

  def create
    special_league_timeline = SpecialLeagueTimeline.new(special_league_timeline_params)

    if special_league_timeline.save
      render :json => special_league_timeline
    else
      render :json => {
        error: 'Special League Timeline was not saved'
      }
    end
  end

  def update
    special_league_timeline = SpecialLeagueTimeline.find(params[:id])

    if special_league_timeline.update(special_league_timeline_params)
      render :json => special_league_timeline
    else
      render :json => {
        error: 'Special League Timeline was not updated'
      }
    end
  end

  def destroy
    special_league_timeline = SpecialLeagueTimeline.find(params[:id])
    special_league_timeline.destroy

    render :json => {
      message: 'Special League Timeline was destroyed'
    }
  end

  private
    def special_league_timeline_params
      params.permit(:name, :start, :end, :max_cp, :notes, :gbl_timeline_id)
    end
end
