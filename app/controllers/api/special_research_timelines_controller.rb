class Api::SpecialResearchTimelinesController < ApplicationController
  def index
    special_research_timelines = SpecialResearchTimeline.all.order(:id)

    render :json => special_research_timelines
  end

  def show
    special_research_timeline = SpecialResearchTimeline.find(params[:id])

    render :json => special_research_timeline
  end

  def create
    special_research_timeline = SpecialResearchTimeline.new(special_research_timeline_params)

    if special_research_timeline.save
      render :json => special_research_timeline
    else
      render :json => {
        error: 'Special Research Timeline was not saved'
      }
    end
  end

  def update
    special_research_timeline = SpecialResearchTimeline.find(params[:id])

    if special_research_timeline.update(special_research_timeline_params)
      render :json => special_research_timeline
    else
      render :json => {
        error: 'Special Research Timeline was not updated'
      }
    end
  end

  def destroy
    special_research_timeline = SpecialResearchTimeline.find(params[:id])
    special_research_timeline.destroy

    render :json => {
      message: 'Special Research Timeline was destroyed'
    }
  end

  private
    def special_research_timeline_params
      params.permit(:name, :released, :timed, :price)
    end
end
