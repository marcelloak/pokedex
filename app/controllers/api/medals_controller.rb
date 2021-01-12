class Api::MedalsController < ApplicationController
  def index
    medals = Medal.all.order(:id)

    render :json => medals
  end

  def show
    medal = Medal.find(params[:id])

    render :json => medal
  end

  def create
    medal = Medal.new(medal_params)

    if medal.save
      render :json => medal
    else
      render :json => {
        error: 'Medal was not saved'
      }
    end
  end

  def update
    medal = Medal.find(params[:id])

    if medal.update(medal_params)
      render :json => medal
    else
      render :json => {
        error: 'Medal was not updated'
      }
    end
  end

  def destroy
    medal = Medal.find(params[:id])
    medal.destroy

    render :json => {
      message: 'Medal was destroyed'
    }
  end

  private
    def medal_params
      params.permit(:name, :bronze, :silver, :gold, :platinum, :reward, :requirement)
    end
end
