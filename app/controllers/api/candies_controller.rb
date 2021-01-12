class Api::CandiesController < ApplicationController
  def index
    candies = Candy.all.order(:id)
    candies = candies.as_json.map { |candy|
      {
        **candy.symbolize_keys,
        family_id: { id: candy.symbolize_keys[:family_id], name: Family.find(candy.symbolize_keys[:family_id])[:name] }
      }
    }

    render :json => candies
  end

  def show
    candy = Candy.find(params[:id])

    render :json => candy
  end

  def create
    candy = Candy.new(candy_params)

    if candy.save
      render :json => candy
    else
      render :json => {
        error: 'Candy was not saved'
      }
    end
  end

  def update
    candy = Candy.find(params[:id])

    if candy.update(candy_params)
      render :json => candy
    else
      render :json => {
        error: 'Candy was not updated'
      }
    end
  end

  def destroy
    candy = Candy.find(params[:id])
    candy.destroy

    render :json => {
      message: 'Candy was destroyed'
    }
  end

  private
    def candy_params
      params.permit(:held, :family_id)
    end
end
