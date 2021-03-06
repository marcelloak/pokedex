class Api::FormRaidTimelinesController < ApplicationController
  def index
    form_raid_timelines = FormRaidTimeline.all.order(:id)

    render :json => form_raid_timelines
  end

  def show
    form_raid_timeline = FormRaidTimeline.find(params[:id])

    render :json => form_raid_timeline
  end

  def create
    form_raid_timeline = FormRaidTimeline.new(form_raid_timeline_params)

    if form_raid_timeline.save
      render :json => form_raid_timeline
    else
      render :json => {
        error: 'Form Raid Timeline was not saved'
      }
    end
  end

  def update
    form_raid_timeline = FormRaidTimeline.find(params[:id])
    form_raid_timelines = form_raid_timelines.as_json.map { |form_raid_timeline|
      {
        **form_raid_timeline.symbolize_keys,
        form_id: { id: form_raid_timeline.symbolize_keys[:form_id], name: "#{Form.find(form_raid_timeline.symbolize_keys[:form_id])[:name]} (#{Pokemon.find(Form.find(form_raid_timeline.symbolize_keys[:form_id])[:pokemon_id])[:name]})" }
      }
    }

    if form_raid_timeline.update(form_raid_timeline_params)
      render :json => form_raid_timeline
    else
      render :json => {
        error: 'Form Raid Timeline was not updated'
      }
    end
  end

  def destroy
    form_raid_timeline = FormRaidTimeline.find(params[:id])
    form_raid_timeline.destroy

    render :json => {
      message: 'Form Raid Timeline was destroyed'
    }
  end

  private
    def form_raid_timeline_params
      params.permit(:start, :end, :form_id)
    end
end
