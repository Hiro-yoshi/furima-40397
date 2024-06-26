FactoryBot.define do
  factory :item do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.sentence }
    category_id { '2' }
    condition_id { '3' }
    shipping_fee_id { '2' }
    prefecture_id { '19' }
    delivery_time_id { '2' }
    price { '10000' }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open("public/images/test.png"), filename: "test.png")
    end
  end
end
