class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @user = current_user
    if @item.save
      redirect_to root_path, notice: "商品が出品されました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])  
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :delivery_time_id, :price).merge(user_id: current_user.id)
  end
end
