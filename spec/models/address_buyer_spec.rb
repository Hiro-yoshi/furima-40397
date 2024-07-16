require 'rails_helper'

RSpec.describe AddressBuyer, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
    @address_buyer = FactoryBot.build(:address_buyer, user_id: @user.id, item_id: @item.id)
  end

  context "商品購入ができるとき" do
    it "必要な情報を全て適切に入力すれば商品購入ができること" do
      expect(@address_buyer).to be_valid
    end

    it "建物名は任意であること" do
      @address_buyer.building = ""
      expect(@address_buyer).to be_valid
    end
  end

  context "商品購入ができないとき" do
    it "郵便番号が必須であること" do
      @address_buyer.post_code = ""
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("Post code can't be blank")
    end

    it "郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと" do
      @address_buyer.post_code = '1234567'
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
    end

    it "都道府県が必須であること" do
      @address_buyer.prefecture_id = ""
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("Prefecture can't be blank")
    end

    it "市区町村が必須であること" do
      @address_buyer.municipality = ""
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("Municipality can't be blank")
    end

    it "番地が必須であること" do
      @address_buyer.street_address = ""
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("Street address can't be blank")
    end

    it "電話番号が必須であること" do
      @address_buyer.phone_number = ""
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("Phone number can't be blank")
    end

    it "電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと" do
      @address_buyer.phone_number = '090-1234-5678'
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
  end
end