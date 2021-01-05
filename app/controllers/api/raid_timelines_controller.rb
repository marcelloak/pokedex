class Api::RaidTimelinesController < ApplicationController
  def index
    raid_timelines = RaidTimeline.all.order(:id)
    raid_timelines = raid_timelines.as_json.map { |raid_timeline|
      {
        **raid_timeline.symbolize_keys,
        pokemon_id: { id: raid_timeline.symbolize_keys[:pokemon_id], name: Pokemon.find(raid_timeline.symbolize_keys[:pokemon_id])[:name] }
      }
    }

    render :json => raid_timelines
  end

  def show
    raid_timeline = RaidTimeline.find(params[:id])

    render :json => raid_timeline
  end

  def create
    raid_timeline = RaidTimeline.new(raid_timeline_params)

    if raid_timeline.save
      render :json => raid_timeline
    else
      render :json => {
        error: 'Raid Timeline was not saved'
      }
    end
  end

  def update
    raid_timeline = RaidTimeline.find(params[:id])

    if raid_timeline.update(raid_timeline_params)
      render :json => raid_timeline
    else
      render :json => {
        error: 'Raid Timeline was not updated'
      }
    end
  end

  def destroy
    raid_timeline = RaidTimeline.find(params[:id])
    raid_timeline.destroy

    render :json => {
      message: 'Raid Timeline was destroyed'
    }
  end

  private
    def raid_timeline_params
      params.permit(:start, :end, :pokemon_id)
    end
end
