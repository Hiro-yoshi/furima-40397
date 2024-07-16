class ShippingAddressesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :check_item_owner, only: [:index, :create]
  before_action :check_item_sold, only: [:index, :create]
  
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @address_buyer = AddressBuyer.new
  end
  
  def create
    @address_buyer = AddressBuyer.new(address_buyer_params)
    if @address_buyer.valid?
      pay_item
      @address_buyer.save
      return redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_item
    @item = Item.find(params[:item_id])
  end
  
  def check_item_owner
    unless @item.user != current_user
      redirect_to root_path
    end
  end
  
  def address_buyer_params
    params.require(:address_buyer).permit(:post_code, :prefecture_id, :municipality, :street_address, :building, :phone_number).merge(token: params[:token], user_id: current_user.id, item_id: @item.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: set_item[:price],
      card: address_buyer_params[:token],
      currency: 'jpy'
    )
  end

  def check_item_sold
    if @item.buyer.present? && @item.user != current_user
      redirect_to root_path
    end
  end
end
