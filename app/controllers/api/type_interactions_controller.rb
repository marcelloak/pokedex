class Api::TypeInteractionsController < ApplicationController
  def index
    type_interactions = TypeInteraction.all.order(:attacking_type_id, :defending_type_id)
    type_interactions = type_interactions.as_json.map { |type| { **type.symbolize_keys, attacking_type_id: { id: type.symbolize_keys[:attacking_type_id], name: Type.find(type.symbolize_keys[:attacking_type_id])[:icon] }, defending_type_id: { id: type.symbolize_keys[:defending_type_id], name: Type.find(type.symbolize_keys[:defending_type_id])[:icon] } } }

    render :json => type_interactions
  end

  def show
    type_interaction = TypeInteraction.find(params[:id])

    render :json => type_interaction
  end

  def create
    type_interaction = TypeInteraction.new(type_interaction_params)

    if type_interaction.save
      render :json => type_interaction
    else
      render :json => {
        error: 'Type Interaction was not saved'
      }
    end
  end

  def update
    type_interaction = TypeInteraction.find(params[:id])

    if type_interaction.update(type_interaction_params)
      render :json => type_interaction
    else
      render :json => {
        error: 'Type Interaction was not updated'
      }
    end
  end

  def destroy
    type_interaction = TypeInteraction.find(params[:id])
    type_interaction.destroy

    render :json => {
      message: 'Type Interaction was destroyed'
    }
  end

  def type_chart
    interactions = Type.all.map { |type| TypeInteraction.where(attacking_type_id: type.id).order(:defending_type_id).to_a.unshift(type)}

    render :json => interactions
  end

  private
    def type_interaction_params
      params.permit(:multiplier, :attacking_type_id, :defending_type_id)
    end
end
