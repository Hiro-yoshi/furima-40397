class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :check_item_owner, only: [:edit, :update]

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

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :delivery_time_id, :price).merge(user_id: current_user.id)
  end

  def check_item_owner
    @item = Item.find(params[:id])
    unless @item.user == current_user
      redirect_to root_path
    end
  end
end
