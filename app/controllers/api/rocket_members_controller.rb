class Api::RocketMembersController < ApplicationController
  def index
    rocket_members = RocketMember.all.order(:id)

    render :json => rocket_members
  end

  def show
    rocket_member = RocketMember.find(params[:id])

    render :json => rocket_member
  end

  def create
    rocket_member = RocketMember.new(rocket_member_params)

    if rocket_member.save
      render :json => rocket_member
    else
      render :json => {
        error: 'Rocket Member was not saved'
      }
    end
  end

  def update
    rocket_member = RocketMember.find(params[:id])

    if rocket_member.update(rocket_member_params)
      render :json => rocket_member
    else
      render :json => {
        error: 'Rocket Member was not updated'
      }
    end
  end

  def destroy
    rocket_member = RocketMember.find(params[:id])
    rocket_member.destroy

    render :json => {
      message: 'Rocket Member was destroyed'
    }
  end

  private
    def rocket_member_params
      params.permit(:name)
    end
end
