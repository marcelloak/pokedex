class Api::PlayersController < ApplicationController
  def index
    players = Player.all.order(:id)

    render :json => players
  end

  def show
    player = Player.find(params[:id])

    render :json => player
  end

  def create
    player = Player.new(player_params)

    if player.save
      render :json => player
    else
      render :json => {
        error: 'Player was not saved'
      }
    end
  end

  def update
    player = Player.find(params[:id])

    if player.update(player_params)
      render :json => player
    else
      render :json => {
        error: 'Player was not updated'
      }
    end
  end

  def destroy
    player = Player.find(params[:id])
    player.destroy

    render :json => {
      message: 'Player was destroyed'
    }
  end

  private
    def player_params
      params.permit(:name, :started, :level, :stardust)
    end
end
