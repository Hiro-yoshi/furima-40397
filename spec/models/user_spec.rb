require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー新規登録" do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録ができる時' do
      it "全ての値が正しく入力されている場合" do
        expect(@user).to be_valid
      end
    end

    context '新規登録ができない時' do
      it "ニックネームが必須であること" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "メールアドレスが必須であること" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "メールアドレスが一意性であること" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it "メールアドレスは、@を含む必要があること" do
        @user.email = "test1example.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "パスワードが必須であること" do
        @user.password = ""
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "パスワードは、6文字以上での入力が必須であること" do
        @user.password = @user.password_confirmation = "short"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "パスワードは、半角英数字混合での入力が必須であること" do
        @user.password = @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end

      it "パスワードとパスワード（確認）は、値の一致が必須であること" do
        @user.password_confirmation = "different123"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "パスワードが半角英字のみでは登録できないこと" do
        @user.password = @user.password_confirmation = "onlyletters"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end

      it "パスワードが半角数字のみでは登録できないこと" do
        @user.password = @user.password_confirmation = "12345678"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end

      it "パスワードが全角文字を含む場合は登録できないこと" do
        @user.password = @user.password_confirmation = "password１２３"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end

      it "姓が必須であること" do
        @user.sei = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Sei can't be blank")
      end

      it "名が必須であること" do
        @user.mei = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Mei can't be blank")
      end

      it "姓（カナ）が必須であること" do
        @user.sei_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Sei kana can't be blank")
      end

      it "名（カナ）が必須であること" do
        @user.mei_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Mei kana can't be blank")
      end

      it "姓は全角（漢字・ひらがな・カタカナ）での入力が必須であること" do
        @user.sei = "yamada"
        @user.valid?
        expect(@user.errors.full_messages).to include("Sei is invalid. Input full-width characters.")
      end

      it "名は全角（漢字・ひらがな・カタカナ）での入力が必須であること" do
        @user.mei = "taro"
        @user.valid?
        expect(@user.errors.full_messages).to include("Mei is invalid. Input full-width characters.")
      end

      it "姓（カナ）は全角（カタカナ）での入力が必須であること" do
        @user.sei_kana = "やまだ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Sei kana is invalid. Input full-width katakana characters.")
      end

      it "名（カナ）は全角（カタカナ）での入力が必須であること" do
        @user.mei_kana = "たろう"
        @user.valid?
        expect(@user.errors.full_messages).to include("Mei kana is invalid. Input full-width katakana characters.")
      end
    end
  end
end
