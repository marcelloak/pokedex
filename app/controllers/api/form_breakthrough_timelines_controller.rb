class Api::FormBreakthroughTimelinesController < ApplicationController
  def index
    form_breakthrough_timelines = FormBreakthroughTimeline.all.order(:id)
    form_breakthrough_timelines = form_breakthrough_timelines.as_json.map { |form_breakthrough_timeline|
      {
        **form_breakthrough_timeline.symbolize_keys,
        form_id: { id: form_breakthrough_timeline.symbolize_keys[:form_id], name: Form.find(form_breakthrough_timeline.symbolize_keys[:form_id])[:name] }
      }
    }

    render :json => form_breakthrough_timelines
  end

  def show
    form_breakthrough_timeline = FormBreakthroughTimeline.find(params[:id])

    render :json => form_breakthrough_timeline
  end

  def create
    form_breakthrough_timeline = FormBreakthroughTimeline.new(form_breakthrough_timeline_params)

    if form_breakthrough_timeline.save
      render :json => form_breakthrough_timeline
    else
      render :json => {
        error:  'Form Breakthrough Timeline was not saved'
      }
    end
  end

  def update
    form_breakthrough_timeline = FormBreakthroughTimeline.find(params[:id])

    if form_breakthrough_timeline.update(form_breakthrough_timeline_params)
      render :json => form_breakthrough_timeline
    else
      render :json => {
        error:  'Form Breakthrough Timeline was not updated'
      }
    end
  end

  def destroy
    form_breakthrough_timeline = FormBreakthroughTimeline.find(params[:id])
    form_breakthrough_timeline.destroy

    render :json => {
      message:  'Form Breakthrough Timeline was destroyed'
    }
  end

  private
    def form_breakthrough_timeline_params
      params.permit(:start, :end, :form_id)
    end
end
