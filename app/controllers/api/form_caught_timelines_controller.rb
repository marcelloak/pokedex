class Api::FormCaughtTimelinesController < ApplicationController
  def index
    form_caught_timelines = FormCaughtTimeline.all.order(:id)
    form_caught_timelines = form_caught_timelines.as_json.map { |form_caught_timeline|
      {
        **form_caught_timeline.symbolize_keys,
        current_form_id: { id: form_caught_timeline.symbolize_keys[:current_form_id], name: "#{Form.find(form_caught_timeline.symbolize_keys[:current_form_id])[:name]} (#{Pokemon.find(Form.find(form_caught_timeline.symbolize_keys[:current_form_id])[:pokemon_id])[:name]})" },
        target_form_id: { id: form_caught_timeline.symbolize_keys[:target_form_id], name: "#{Form.find(form_caught_timeline.symbolize_keys[:target_form_id])[:name]} (#{Pokemon.find(Form.find(form_caught_timeline.symbolize_keys[:target_form_id])[:pokemon_id])[:name]})" },
        fast_move_id: { id: form_caught_timeline.symbolize_keys[:fast_move_id], name: FastMove.find(form_caught_timeline.symbolize_keys[:fast_move_id])[:name] },
        first_charge_move_id: { id: form_caught_timeline.symbolize_keys[:first_charge_move_id], name: ChargeMove.find(form_caught_timeline.symbolize_keys[:first_charge_move_id])[:name] },
        second_charge_move_id: { id: form_caught_timeline.symbolize_keys[:second_charge_move_id], name: ChargeMove.find(form_caught_timeline.symbolize_keys[:second_charge_move_id])[:name] },
        original_owner_id: { id: form_caught_timeline.symbolize_keys[:original_owner_id], name: Player.find(form_caught_timeline.symbolize_keys[:original_owner_id])[:name] },
        current_owner_id: { id: form_caught_timeline.symbolize_keys[:current_owner_id], name: Player.find(form_caught_timeline.symbolize_keys[:current_owner_id])[:name] }
      }
    }

    render :json => form_caught_timelines
  end

  def show
    form_caught_timeline = FormCaughtTimeline.find(params[:id])

    render :json => form_caught_timeline
  end

  def create
    form_caught_timeline = FormCaughtTimeline.new(form_caught_timeline_params)

    if form_caught_timeline.save
      render :json => form_caught_timeline
    else
      render :json => {
        error: 'Form Caught Timeline was not saved'
      }
    end
  end

  def update
    form_caught_timeline = FormCaughtTimeline.find(params[:id])

    if form_caught_timeline.update(form_caught_timeline_params)
      render :json => form_caught_timeline
    else
      render :json => {
        error: 'Form Caught Timeline was not updated'
      }
    end
  end

  def destroy
    form_caught_timeline = FormCaughtTimeline.find(params[:id])
    form_caught_timeline.destroy

    render :json => {
      message: 'Form Caught Timeline was destroyed'
    }
  end

  private
    def form_caught_timeline_params
      params.permit(:caught, :attack, :defence, :stamina, :current_level, :target_level, :gender, :shadow, :purified, :shiny, :lucky, :charge_move_unlocked, :transferred, :current_form_id, :target_form_id, :fast_move_id, :first_charge_move_id, :second_charge_move_id, :original_owner_id, :current_owner_id)
    end
end
