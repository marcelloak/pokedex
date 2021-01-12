class Api::CollectionChallengesController < ApplicationController
  def index
    collection_challenges = CollectionChallenge.all.order(:id)

    render :json => collection_challenges
  end

  def show
    collection_challenge = CollectionChallenge.find(params[:id])

    render :json => collection_challenge
  end

  def create
    collection_challenge = CollectionChallenge.new(collection_challenge_params)

    if collection_challenge.save
      render :json => collection_challenge
    else
      render :json => {
        error: 'Collection Challenge was not saved'
      }
    end
  end

  def update
    collection_challenge = CollectionChallenge.find(params[:id])

    if collection_challenge.update(collection_challenge_params)
      render :json => collection_challenge
    else
      render :json => {
        error: 'Collection Challenge was not updated'
      }
    end
  end

  def destroy
    collection_challenge = CollectionChallenge.find(params[:id])
    collection_challenge.destroy

    render :json => {
      message: 'Collection Challenge was destroyed'
    }
  end

  private
    def collection_challenge_params
      params.permit(:name, :released)
    end
end
