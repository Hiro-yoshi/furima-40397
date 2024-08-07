class AddressBuyer
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipality, :street_address, :building, :phone_number, :user_id, :item_id, :token 

  with_options presence: true do
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipality
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid. Input only number" }
    validates :token
    validates :user_id
    validates :item_id

  end

  def save
    buyer = Buyer.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, street_address: street_address, building: building, phone_number: phone_number, buyer_id: buyer.id)
  end
end