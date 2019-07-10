class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    Merchant.create(merchant_params)
    redirect_to merchants_path
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    redirect_to merchant_path
  end

  def destroy
    Merchant.destroy(params[:id])
    redirect_to merchants_path
  end

  private

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
