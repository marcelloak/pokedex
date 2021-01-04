class Api::ItemTimelinesController < ApplicationController
  def index
    item_timelines = ItemTimeline.all.order(:id)

    render :json => item_timelines
  end

  def show
    item_timeline = ItemTimeline.find(params[:id])

    render :json => item_timeline
  end

  def create
    item_timeline = ItemTimeline.new(item_timeline_params)

    if item_timeline.save
      render :json => item_timeline
    else
      render :json => {
        error: 'Item Timeline was not saved'
      }
    end
  end

  def update
    item_timeline = ItemTimeline.find(params[:id])

    if item_timeline.update(item_timeline_params)
      render :json => item_timeline
    else
      render :json => {
        error: 'Item Timeline was not updated'
      }
    end
  end

  def destroy
    item_timeline = ItemTimeline.find(params[:id])
    item_timeline.destroy

    render :json => {
      message: 'Item Timeline was destroyed'
    }
  end

  private
    def item_timeline_params
      params.permit(:release, :name)
    end
end
