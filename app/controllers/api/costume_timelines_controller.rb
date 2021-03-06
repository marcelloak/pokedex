class Api::CostumeTimelinesController < ApplicationController
  def index
    costume_timelines = CostumeTimeline.all.order(:id)
    costume_timelines = costume_timelines.as_json.map { |costume_timeline|
      {
        **costume_timeline.symbolize_keys,
        costume_id: { id: costume_timeline.symbolize_keys[:costume_id], name: "#{Costume.find(costume_timeline.symbolize_keys[:costume_id])[:name]} (#{Pokemon.find(Costume.find(costume_timeline.symbolize_keys[:costume_id])[:pokemon_id])[:name]})" }
      }
    }

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
