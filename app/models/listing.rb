class Listing < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { in: 1...101 }
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 5 }
end
