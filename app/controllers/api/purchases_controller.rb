class Api::PurchasesController < ApplicationController
  def index
    purchases = Purchase.all.order(:id)

    render :json => purchases
  end

  def show
    purchase = Purchase.find(params[:id])

    render :json => purchase
  end

  def create
    purchase = Purchase.new(purchase_params)

    if purchase.save
      render :json => purchase
    else
      render :json => {
        error: 'Purchase was not saved'
      }
    end
  end

  def update
    purchase = Purchase.find(params[:id])

    if purchase.update(purchase_params)
      render :json => purchase
    else
      render :json => {
        error: 'Purchase was not updated'
      }
    end
  end

  def destroy
    purchase = Purchase.find(params[:id])
    purchase.destroy

    render :json => {
      message: 'Purchase was destroyed'
    }
  end

  private
    def purchase_params
      params.permit(:purchased, :coins, :ticket, :box, :price)
    end
end
