class Api::CostumeCaughtTimelinesController < ApplicationController
  def index
    costume_caught_timelines = CostumeCaughtTimeline.all.order(:id)
    costume_caught_timelines = costume_caught_timelines.as_json.map { |costume_caught_timeline|
      {
        **costume_caught_timeline.symbolize_keys,
        current_costume_id: { id: costume_caught_timeline.symbolize_keys[:current_costume_id], name: "#{Costume.find(costume_caught_timeline.symbolize_keys[:current_costume_id])[:name]} (#{Pokemon.find(Costume.find(costume_caught_timeline.symbolize_keys[:current_costume_id])[:pokemon_id])[:name]})" },
        target_costume_id: { id: costume_caught_timeline.symbolize_keys[:target_costume_id], name: "#{Costume.find(costume_caught_timeline.symbolize_keys[:target_costume_id])[:name]} (#{Pokemon.find(Costume.find(costume_caught_timeline.symbolize_keys[:target_costume_id])[:pokemon_id])[:name]})" },
        fast_move_id: { id: costume_caught_timeline.symbolize_keys[:fast_move_id], name: FastMove.find(costume_caught_timeline.symbolize_keys[:fast_move_id])[:name] },
        first_charge_move_id: { id: costume_caught_timeline.symbolize_keys[:first_charge_move_id], name: ChargeMove.find(costume_caught_timeline.symbolize_keys[:first_charge_move_id])[:name] },
        second_charge_move_id: { id: costume_caught_timeline.symbolize_keys[:second_charge_move_id], name: ChargeMove.find(costume_caught_timeline.symbolize_keys[:second_charge_move_id])[:name] },
        original_owner_id: { id: costume_caught_timeline.symbolize_keys[:original_owner_id], name: Player.find(costume_caught_timeline.symbolize_keys[:original_owner_id])[:name] },
        current_owner_id: { id: costume_caught_timeline.symbolize_keys[:current_owner_id], name: Player.find(costume_caught_timeline.symbolize_keys[:current_owner_id])[:name] }
      }
    }
    
    render :json => costume_caught_timelines
  end

  def show
    costume_caught_timeline = CostumeCaughtTimeline.find(params[:id])

    render :json => costume_caught_timeline
  end

  def create
    costume_caught_timeline = CostumeCaughtTimeline.new(costume_caught_timeline_params)

    if costume_caught_timeline.save
      render :json => costume_caught_timeline
    else
      render :json => {
        error: 'Costume Caught Timeline was not saved'
      }
    end
  end

  def update
    costume_caught_timeline = CostumeCaughtTimeline.find(params[:id])

    if costume_caught_timeline.update(costume_caught_timeline_params)
      render :json => costume_caught_timeline
    else
      render :json => {
        error: 'Costume Caught Timeline was not updated'
      }
    end
  end

  def destroy
    costume_caught_timeline = CostumeCaughtTimeline.find(params[:id])
    costume_caught_timeline.destroy

    render :json => {
      message: 'Costume Caught Timeline was destroyed'
    }
  end

  private
    def costume_caught_timeline_params
      params.permit(:caught, :attack, :defence, :stamina, :current_level_id, :target_level_id, :gender, :shadow, :purified, :shiny, :lucky, :charge_move_unlocked, :transferred, :current_costume_id, :target_costume_id, :fast_move_id, :first_charge_move_id, :second_charge_move_id, :original_owner_id, :current_owner_id, :high_iv, :raider, :pvp, :defender)
    end
end
