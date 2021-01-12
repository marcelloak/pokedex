class Api::RocketMemberShadowsController < ApplicationController
  def index
    rocket_member_shadows = RocketMemberShadow.all.order(:id)
    rocket_member_shadows = rocket_member_shadows.as_json.map { |rocket_member_shadow|
      {
        **rocket_member_shadow.symbolize_keys,
        rocket_member_id: { id: rocket_member_shadow.symbolize_keys[:rocket_member_id], name: RocketMember.find(rocket_member_shadow.symbolize_keys[:rocket_member_id])[:name] },
        pokemon_id: { id: rocket_member_shadow.symbolize_keys[:pokemon_id], name: Pokemon.find(rocket_member_shadow.symbolize_keys[:pokemon_id])[:name] }
      }
    }

    render :json => rocket_member_shadows
  end

  def show
    rocket_member_shadow = RocketMemberShadow.find(params[:id])

    render :json => rocket_member_shadow
  end

  def create
    rocket_member_shadow = RocketMemberShadow.new(rocket_member_shadow_params)

    if rocket_member_shadow.save
      render :json => rocket_member_shadow
    else
      render :json => {
        error: 'Rocket Member Shadow was not saved'
      }
    end
  end

  def update
    rocket_member_shadow = RocketMemberShadow.find(params[:id])

    if rocket_member_shadow.update(rocket_member_shadow_params)
      render :json => rocket_member_shadow
    else
      render :json => {
        error: 'Rocket Member Shadow was not updated'
      }
    end
  end

  def destroy
    rocket_member_shadow = RocketMemberShadow.find(params[:id])
    rocket_member_shadow.destroy

    render :json => {
      message: 'Rocket Member Shadow was destroyed'
    }
  end

  private
    def rocket_member_shadow_params
      params.permit(:rocket_member_id, :pokemon_id)
    end
end
