class Listing < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { in: 1...101 }
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 5 }
  has_many_attached :picture
  has_many :listing_categories
  has_many :categories, through: :listing_categories
  has_many :cart_listings
  has_many :carts, through: :cart_listings
  has_many :order_listings
  has_many :orders, through: :order_listings
  has_one :location
end
