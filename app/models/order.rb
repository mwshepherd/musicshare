class Order < ApplicationRecord
  belongs_to :user
  has_many :order_listings
  has_many :listings, through: :order_listings
end
