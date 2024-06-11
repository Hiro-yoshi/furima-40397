FactoryBot.define do
  factory :user do
    nickname { "test1" }
    email { "test1@example.com" }
    password { "test1password" }
    password_confirmation { "test1password" }
    sei { "山田" }
    mei { "太郎" }
    sei_kana { "ヤマダ" }
    mei_kana { "タロウ" }
    birth_date { "1949-01-19" }
  end
end