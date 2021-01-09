class Api::CostumeRaidTimelinesController < ApplicationController
  def index
    costume_raid_timelines = CostumeRaidTimeline.all.order(:id)
    costume_raid_timelines = costume_raid_timelines.as_json.map { |costume_raid_timeline|
      {
        **costume_raid_timeline.symbolize_keys,
        costume_id: { id: costume_raid_timeline.symbolize_keys[:costume_id], name: "#{Costume.find(costume_raid_timeline.symbolize_keys[:costume_id])[:name]} (#{Pokemon.find(Costume.find(costume_raid_timeline.symbolize_keys[:costume_id])[:pokemon_id])[:name]})" }
      }
    }

    render :json => costume_raid_timelines
  end

  def show
    costume_raid_timeline = CostumeRaidTimeline.find(params[:id])

    render :json => costume_raid_timeline
  end

  def create
    costume_raid_timeline = CostumeRaidTimeline.new(costume_raid_timeline_params)

    if costume_raid_timeline.save
      render :json => costume_raid_timeline
    else
      render :json => {
        error: 'Costume Raid Timeline was not saved'
      }
    end
  end

  def update
    costume_raid_timeline = CostumeRaidTimeline.find(params[:id])

    if costume_raid_timeline.update(costume_raid_timeline_params)
      render :json => costume_raid_timeline
    else
      render :json => {
        error: 'Costume Raid Timeline was not updated'
      }
    end
  end

  def destroy
    costume_raid_timeline = CostumeRaidTimeline.find(params[:id])
    costume_raid_timeline.destroy

    render :json => {
      message: 'Costume Raid Timeline was destroyed'
    }
  end

  private
    def costume_raid_timeline_params
      params.permit(:start, :end, :costume_id)
    end
end
