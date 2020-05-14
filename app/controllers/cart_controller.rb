class CartController < ApplicationController
    def index
        @cart_items = load_cart
        @total = cart_total
    end

    def create
        # @listing = 
        puts '*' * 30
        puts params
        puts params[:id]
        puts '*' * 30
        @listing = Listing.find(params[:id])
        puts '*' * 30
        p @listing
        puts '*' * 30
        CartListing.create(cart: current_user.cart, listing: @listing)
        redirect_to cart_index_path
    end

    def destroy
        listing = CartListing.find(params[:id])
        listing.destroy unless listing.nil?
        redirect_to cart_index_path
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
