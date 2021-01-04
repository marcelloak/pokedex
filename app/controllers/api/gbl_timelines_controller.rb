class Api::GblTimelinesController < ApplicationController
  def index
    gbl_timelines = GblTimeline.all.order(:id)

    render :json => gbl_timelines
  end

  def show
    gbl_timeline = GblTimeline.find(params[:id])

    render :json => gbl_timeline
  end

  def create
    gbl_timeline = GblTimeline.new(gbl_timeline_params)

    if gbl_timeline.save
      render :json => gbl_timeline
    else
      render :json => {
        error: 'Gbl Timeline was not saved'
      }
    end
  end

  def update
    gbl_timeline = GblTimeline.find(params[:id])

    if gbl_timeline.update(gbl_timeline_params)
      render :json => gbl_timeline
    else
      render :json => {
        error: 'Gbl Timeline was not updated'
      }
    end
  end

  def destroy
    gbl_timeline = GblTimeline.find(params[:id])
    gbl_timeline.destroy

    render :json => {
      message: 'Gbl Timeline was destroyed'
    }
  end

  private
    def gbl_timeline_params
      params.permit(:name, :great_start, :great_end, :ultra_start, :ultra_end, :master_start, :master_end, :all_start, :all_end)
    end
end
