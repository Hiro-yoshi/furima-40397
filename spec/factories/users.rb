FactoryBot.define do
  factory :user do
    nickname { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { 'test1password' }
    password_confirmation { 'test1password' }
    sei { '山田' }
    mei { '太郎' }
    sei_kana { 'ヤマダ' }
    mei_kana { 'タロウ' }
    birth_date { '1949-01-19' }
  end
end
