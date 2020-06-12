class Location < ApplicationRecord
    geocoded_by :address
    after_validation :geocode
    has_one :listings
end
