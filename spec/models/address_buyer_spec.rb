require 'rails_helper'

RSpec.describe AddressBuyer, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
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

    it "都道府県に「---」が選択されている場合は購入できない" do
      @address_buyer.prefecture_id = "1"
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

    it "電話番号が空では購入できない" do
      @address_buyer.phone_number = ""
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("Phone number can't be blank")
    end

    it "電話番号が9桁以下では購入できないこと" do
      @address_buyer.phone_number = '090123456'
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
    
    it "電話番号が12桁以上では購入できないこと" do
      @address_buyer.phone_number = '090123456789'
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("Phone number is invalid. Input only number")
    end

    it "電話番号に半角数字以外が含まれている場合は購入できないこと" do
      @address_buyer.phone_number = '090-1234-5678'
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("Phone number is invalid. Input only number")
    end

    it "tokenが空では購入できないこと" do
      @address_buyer.token = ""
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("Token can't be blank")
    end

    it "userが紐付いていなければ購入できないこと" do
      @address_buyer.user_id = ""
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("User can't be blank")
    end
    
    it "itemが紐付いていなければ購入できないこと" do
      @address_buyer.item_id = ""
      @address_buyer.valid?
      expect(@address_buyer.errors.full_messages).to include("Item can't be blank")
    end
  end
end