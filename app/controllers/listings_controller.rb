class ListingsController < ApplicationController
    before_action :set_listing, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]

    def index
        @listings = Listing.all
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
    end

    def edit
    end

    def update
    end
    
    def destroy
    end

    private
    def listing_params
        params.require(:listing).permit(:title, :price, :description)
    end

    def set_listing
        id = params[:id]
        @listing = Listing.find(id)
    end
end
