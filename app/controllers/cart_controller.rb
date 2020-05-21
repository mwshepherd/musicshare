class CartController < ApplicationController
    def index
        @cart = current_user.cart
        @cart_items = load_cart
        @total = cart_total
    end

    def create
        # If a user doesn't have a cart, it creates a cart for the user
        if !current_user.cart
            Cart.create(user: current_user)
        end
        # Finds the listing based on the listing id in the params
        @listing = Listing.find(params[:id])
        # Creates the cartlisting and adds it to the current users cart
        CartListing.create(cart: current_user.cart, listing: @listing)
        redirect_to cart_index_path
    end

    def destroy
        # Finds the listing based on the params and deletes it from the cart
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
