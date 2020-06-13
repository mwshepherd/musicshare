class ProfilesController < ApplicationController
    def index
        # Will find the user based upon the username in the query string
        @user = User.where(username: params[:username])[0]
        @rating = get_rating(@user)

    end

    def listings
        # Retreives the current users listings
        @listings = current_user.listings
    end

    def orders
        # Retreives the current users orders
        @orders = current_user.orders
    end

    private

    def get_rating(user)
        sum = 0

        if user.ratings.length < 1
            return 'No Ratings Yet'
        else
            user.ratings.each do |rating|
                sum += rating.score
            end

            return (sum.to_f / user.ratings.length.to_f).round(2)
        end
    end
end
