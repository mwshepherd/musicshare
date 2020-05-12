class ListingsController < ApplicationController
    def index
    end

    def new
        @listing = Listing.new
    end

    def create
        @listing = Listing.new(listing_params)
        @listing.user = current_user

        if @listing.save
            redirect_to @listing
        else
            render :new
        end
    end

    def show
        @listing = Listing.find(params[:id])
    end

    private
    def listing_params
        params.require(:listing).permit(:title, :price, :description)
    end
end
