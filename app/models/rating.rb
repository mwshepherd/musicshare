class Rating < ApplicationRecord
    has_many :user_listings
end
