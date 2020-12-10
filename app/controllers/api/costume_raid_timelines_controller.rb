class Api::CostumeRaidTimelinesController < ApplicationController
  def index
    costume_raid_timelines = CostumeRaidTimeline.all

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
