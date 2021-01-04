class Api::EventTimelinesController < ApplicationController
  def index
    event_timelines = EventTimeline.all.order(:id)

    render :json => event_timelines
  end

  def show
    event_timeline = EventTimeline.find(params[:id])

    render :json => event_timeline
  end

  def create
    event_timeline = EventTimeline.new(event_timeline_params)

    if event_timeline.save
      render :json => event_timeline
    else
      render :json => {
        error: 'Event Timeline was not saved'
      }
    end
  end

  def update
    event_timeline = EventTimeline.find(params[:id])

    if event_timeline.update(event_timeline_params)
      render :json => event_timeline
    else
      render :json => {
        error: 'Event Timeline was not updated'
      }
    end
  end

  def destroy
    event_timeline = EventTimeline.find(params[:id])
    event_timeline.destroy

    render :json => {
      message: 'Event Timeline was destroyed'
    }
  end

  private
    def event_timeline_params
      params.permit(:start, :end, :name)
    end
end
