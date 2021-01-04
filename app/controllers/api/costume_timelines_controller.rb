class Api::CostumeTimelinesController < ApplicationController
  def index
    costume_timelines = CostumeTimeline.all.order(:id)

    render :json => costume_timelines
  end

  def show
    costume_timeline = CostumeTimeline.find(params[:id])

    render :json => costume_timeline
  end

  def create
    costume_timeline = CostumeTimeline.new(costume_timeline_params)

    if costume_timeline.save
      render :json => costume_timeline
    else
      render :json => {
        error: 'Costume Timeline was not saved'
      }
    end
  end

  def update
    costume_timeline = CostumeTimeline.find(params[:id])

    if costume_timeline.update(costume_timeline_params)
      render :json => costume_timeline
    else
      render :json => {
        error: 'Costume Timeline was not updated'
      }
    end
  end

  def destroy
    costume_timeline = CostumeTimeline.find(params[:id])
    costume_timeline.destroy

    render :json => {
      message: 'Costume Timeline was destroyed'
    }
  end

  private
    def costume_timeline_params
      params.permit(:released, :available, :ignored, :costume_id)
    end
end
