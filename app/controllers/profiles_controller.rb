class ProfilesController < ApplicationController
    def index
        # Will find the user based upon the username in the query string
        @user = User.where(username: params[:username])[0]
    end

    def listings
        # Retreives the current users listings
        @listings = current_user.listings
    end

    def orders
        # Retreives the current users orders
        @orders = current_user.orders
    end

end
