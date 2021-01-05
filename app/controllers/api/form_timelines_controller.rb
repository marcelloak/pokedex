class Api::FormTimelinesController < ApplicationController
  def index
    form_timelines = FormTimeline.all.order(:id)
    form_timelines = form_timelines.as_json.map { |form_timeline|
      {
        **form_timeline.symbolize_keys,
        form_id: { id: form_timeline.symbolize_keys[:form_id], name: Form.find(form_timeline.symbolize_keys[:form_id])[:name] }
      }
    }

    render :json => form_timelines
  end

  def show
    form_timeline = FormTimeline.find(params[:id])

    render :json => form_timeline
  end

  def create
    form_timeline = FormTimeline.new(form_timeline_params)

    if form_timeline.save
      render :json => form_timeline
    else
      render :json => {
        error: 'Form Timeline was not saved'
      }
    end
  end

  def update
    form_timeline = FormTimeline.find(params[:id])

    if form_timeline.update(form_timeline_params)
      render :json => form_timeline
    else
      render :json => {
        error: 'Form Timeline was not updated'
      }
    end
  end

  def destroy
    form_timeline = FormTimeline.find(params[:id])
    form_timeline.destroy

    render :json => {
      message: 'Form Timeline was destroyed'
    }
  end

  private
    def form_timeline_params
      params.permit(:released, :available, :ignored, :form_id)
    end
end
