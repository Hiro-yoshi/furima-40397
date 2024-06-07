require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー新規登録" do
    it "ニックネームが必須であること" do
      user = User.new(nickname: "", email: "test1@example", password: "test1password", password_confirmation: "test1password", sei: "山田", mei: "太郎", sei_kana: "ヤマダ", mei_kana: "タロウ", birth_date: 1949-01-19)
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "メールアドレスが必須であること" do
      user = User.new(nickname: "test1", email: "", password: "test1password", password_confirmation: "test1password", sei: "山田", mei: "太郎", sei_kana: "ヤマダ", mei_kana: "タロウ", birth_date: "1949-01-19")
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "メールアドレスが一意性であること" do
      User.create(nickname: "test1", email: "test1@example.com", password: "test1password", password_confirmation: "test1password", sei: "山田", mei: "太郎", sei_kana: "ヤマダ", mei_kana: "タロウ", birth_date: "1949-01-19")
      user = User.new(nickname: "test2", email: "test1@example.com", password: "test2password", password_confirmation: "test2password", sei: "佐藤", mei: "次郎", sei_kana: "サトウ", mei_kana: "ジロウ", birth_date: "1950-02-20")
      user.valid?
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it "メールアドレスは、@を含む必要があること" do
      user = User.new(nickname: "test1", email: "test1example.com", password: "test1password", password_confirmation: "test1password", sei: "山田", mei: "太郎", sei_kana: "ヤマダ", mei_kana: "タロウ", birth_date: "1949-01-19")
      user.valid?
      expect(user.errors.full_messages).to include("Email is invalid")
    end

    it "パスワードが必須であること" do
      user = User.new(nickname: "test1", email: "test1@example.com", password: "", password_confirmation: "", sei: "山田", mei: "太郎", sei_kana: "ヤマダ", mei_kana: "タロウ", birth_date: "1949-01-19")
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it "パスワードは、6文字以上での入力が必須であること" do
      user = User.new(nickname: "test1", email: "test1@example.com", password: "short", password_confirmation: "short", sei: "山田", mei: "太郎", sei_kana: "ヤマダ", mei_kana: "タロウ", birth_date: "1949-01-19")
      user.valid?
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "パスワードは、半角英数字混合での入力が必須であること" do
      user = User.new(nickname: "test1", email: "test1@example.com", password: "123456", password_confirmation: "123456", sei: "山田", mei: "太郎", sei_kana: "ヤマダ", mei_kana: "タロウ", birth_date: "1949-01-19")
      user.valid?
      expect(user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
    end

    it "パスワードとパスワード（確認）は、値の一致が必須であること" do
      user = User.new(nickname: "test1", email: "test1@example.com", password: "password123", password_confirmation: "different123", sei: "山田", mei: "太郎", sei_kana: "ヤマダ", mei_kana: "タロウ", birth_date: "1949-01-19")
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
  #pending "add some examples to (or delete) #{__FILE__}"
end
