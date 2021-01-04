class Api::SpecialLeagueTypeLimitsController < ApplicationController
  def index
    special_league_type_limits = SpecialLeagueTypeLimit.all.order(:id)

    render :json => special_league_type_limits
  end

  def show
    special_league_type_limit = SpecialLeagueTypeLimit.find(params[:id])

    render :json => special_league_type_limit
  end

  def create
    special_league_type_limit = SpecialLeagueTypeLimit.new(special_league_type_limit_params)

    if special_league_type_limit.save
      render :json => special_league_type_limit
    else
      render :json => {
        error: 'Special League Type Limit was not saved'
      }
    end
  end

  def update
    special_league_type_limit = SpecialLeagueTypeLimit.find(params[:id])

    if special_league_type_limit.update(special_league_type_limit_params)
      render :json => special_league_type_limit
    else
      render :json => {
        error: 'Special League Type Limit was not updated'
      }
    end
  end

  def destroy
    special_league_type_limit = SpecialLeagueTypeLimit.find(params[:id])
    special_league_type_limit.destroy

    render :json => {
      message: 'Special League Type Limit was destroyed'
    }
  end

  private
    def special_league_type_limit_params
      params.permit(:special_league_timeline_id, :type_id)
    end
end
