class Api::ShinyCostumeTimelinesController < ApplicationController
  def index
    shiny_costume_timelines = ShinyCostumeTimeline.all.order(:id)
    shiny_costume_timelines = shiny_costume_timelines.as_json.map { |shiny_costume_timeline|
      {
        **shiny_costume_timeline.symbolize_keys,
        costume_id: { id: shiny_costume_timeline.symbolize_keys[:costume_id], name: "#{Costume.find(shiny_costume_timeline.symbolize_keys[:costume_id])[:name]} (#{Pokemon.find(Costume.find(shiny_costume_timeline.symbolize_keys[:costume_id])[:pokemon_id])[:name]})" }
      }
    }

    render :json => shiny_costume_timelines
  end

  def show
    shiny_costume_timeline = ShinyCostumeTimeline.find(params[:id])

    render :json => shiny_costume_timeline
  end

  def create
    shiny_costume_timeline = ShinyCostumeTimeline.new(shiny_costume_timeline_params)

    if shiny_costume_timeline.save
      render :json => shiny_costume_timeline
    else
      render :json => {
        error: 'Shiny Costume Timeline was not saved'
      }
    end
  end

  def update
    shiny_costume_timeline = ShinyCostumeTimeline.find(params[:id])

    if shiny_costume_timeline.update(shiny_costume_timeline_params)
      render :json => shiny_costume_timeline
    else
      render :json => {
        error: 'Shiny Costume Timeline was not updated'
      }
    end
  end

  def destroy
    shiny_costume_timeline = ShinyCostumeTimeline.find(params[:id])
    shiny_costume_timeline.destroy

    render :json => {
      message: 'Shiny Costume Timeline was destroyed'
    }
  end

  private
    def shiny_costume_timeline_params
      params.permit(:released, :available, :ignored, :costume_id)
    end
end
