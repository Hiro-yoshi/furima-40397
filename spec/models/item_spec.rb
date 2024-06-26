require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "商品出品" do
    before do
      @item = FactoryBot.build(:item)
    end

    context '商品出品ができる時' do
      it "全ての値が正しく入力されている場合" do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができない時' do
      it "商品画像がが必須であること" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it "商品名が必須であること" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it "商品説明があること" do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it "カテゴリーの情報が必須であること" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it "商品の状態の情報が必須であること" do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it "配送料の負担の情報が必須であること" do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end

      it "発送元の地域の情報が必須であること" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it "発送までの日数の情報が必須であること" do
        @item.delivery_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery time can't be blank")
      end

      it "価格の情報が必須であること" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it "価格が300円以上であることが必須であること" do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it "価格が9,999,999円以下であることが必須であること" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end

      it "価格は半角数値のみ保存可能であること" do
        @item.price = "５０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it "ユーザーが紐づいていないと保存できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
