class CartController < ApplicationController
    def index
        @cart_items = load_cart
        @total = cart_total
    end

    private

    def load_cart
        current_user.cart.cart_listings
    end

    def cart_total
        sum = 0
        @cart_items.each do |listing|
            sum += listing.listing.price
        end
        return sum
    end
end
