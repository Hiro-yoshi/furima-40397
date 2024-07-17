FactoryBot.define do
  factory :address_buyer do
    post_code { '123-4567' }
    prefecture_id { '12' }
    municipality { 'test' }
    street_address { 'test' }
    building { 'test' }
    phone_number { '09012345678' }
    token { 'tok_sample12345678' }

  end
end
