class Api::FeatureTimelinesController < ApplicationController
  def index
    feature_timelines = FeatureTimeline.all

    render :json => feature_timelines
  end

  def show
    feature_timeline = FeatureTimeline.find(params[:id])

    render :json => feature_timeline
  end

  def create
    feature_timeline = FeatureTimeline.new(feature_timeline_params)

    if feature_timeline.save
      render :json => feature_timeline
    else
      render :json => {
        error: 'Feature Timeline was not saved'
      }
    end
  end

  def update
    feature_timeline = FeatureTimeline.find(params[:id])

    if feature_timeline.update(feature_timeline_params)
      render :json => feature_timeline
    else
      render :json => {
        error: 'Feature Timeline was not updated'
      }
    end
  end

  def destroy
    feature_timeline = FeatureTimeline.find(params[:id])
    feature_timeline.destroy

    render :json => {
      message: 'Feature Timeline was destroyed'
    }
  end

  private
    def feature_timeline_params
      params.permit(:release, :name)
    end
end
