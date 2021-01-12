class Api::CostumeBreakthroughTimelinesController < ApplicationController
  def index
    costume_breakthrough_timelines = CostumeBreakthroughTimeline.all.order(:id)
    costume_breakthrough_timelines = costume_breakthrough_timelines.as_json.map { |costume_breakthrough_timeline|
      {
        **costume_breakthrough_timeline.symbolize_keys,
        costume_id: { id: costume_breakthrough_timeline.symbolize_keys[:costume_id], name: "#{Costume.find(costume_breakthrough_timeline.symbolize_keys[:costume_id])[:name]} (#{Pokemon.find(Costume.find(costume_breakthrough_timeline.symbolize_keys[:costume_id])[:pokemon_id])[:name]})" }
      }
    }

    render :json => costume_breakthrough_timelines
  end

  def show
    costume_breakthrough_timeline = CostumeBreakthroughTimeline.find(params[:id])

    render :json => costume_breakthrough_timeline
  end

  def create
    costume_breakthrough_timeline = CostumeBreakthroughTimeline.new(costume_breakthrough_timeline_params)

    if costume_breakthrough_timeline.save
      render :json => costume_breakthrough_timeline
    else
      render :json => {
        error:  'Costume Breakthrough Timeline was not saved'
      }
    end
  end

  def update
    costume_breakthrough_timeline = CostumeBreakthroughTimeline.find(params[:id])

    if costume_breakthrough_timeline.update(costume_breakthrough_timeline_params)
      render :json => costume_breakthrough_timeline
    else
      render :json => {
        error:  'Costume Breakthrough Timeline was not updated'
      }
    end
  end

  def destroy
    costume_breakthrough_timeline = CostumeBreakthroughTimeline.find(params[:id])
    costume_breakthrough_timeline.destroy

    render :json => {
      message:  'Costume Breakthrough Timeline was destroyed'
    }
  end

  private
    def costume_breakthrough_timeline_params
      params.permit(:start, :end, :costume_id)
    end
end
