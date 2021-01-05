class Api::BreakthroughTimelinesController < ApplicationController
  def index
    breakthrough_timelines = BreakthroughTimeline.all.order(:id)
    breakthrough_timelines = breakthrough_timelines.as_json.map { |breakthrough_timeline|
      {
        **breakthrough_timeline.symbolize_keys, pokemon_id: { id: breakthrough_timeline.symbolize_keys[:pokemon_id], name: Pokemon.find(breakthrough_timeline.symbolize_keys[:pokemon_id])[:name] }
      }
    }

    render :json => breakthrough_timelines
  end

  def show
    breakthrough_timeline = BreakthroughTimeline.find(params[:id])

    render :json => breakthrough_timeline
  end

  def create
    breakthrough_timeline = BreakthroughTimeline.new(breakthrough_timeline_params)

    if breakthrough_timeline.save
      render :json => breakthrough_timeline
    else
      render :json => {
        error: 'Breakthrough Timeline was not saved'
      }
    end
  end

  def update
    breakthrough_timeline = BreakthroughTimeline.find(params[:id])

    if breakthrough_timeline.update(breakthrough_timeline_params)
      render :json => breakthrough_timeline
    else
      render :json => {
        error: 'Breakthrough Timeline was not updated'
      }
    end
  end

  def destroy
    breakthrough_timeline = BreakthroughTimeline.find(params[:id])
    breakthrough_timeline.destroy

    render :json => {
      message: 'Breakthrough Timeline was destroyed'
    }
  end

  private
    def breakthrough_timeline_params
      params.permit(:start, :end, :pokemon_id)
    end
end
