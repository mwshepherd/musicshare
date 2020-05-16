class ListingsController < ApplicationController
    before_action :set_listing, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]
    load_and_authorize_resource

    def index
        @listings = Listing.all
    end

    def browse
        @categories = Category.all
        @category = params[:category]
        if @category.present?
            @listings = Category.find(@category).listings
        end
    end

    def new
        @listing = Listing.new
    end

    def create
        @listing = Listing.new(listing_params)
        @listing.user = current_user
        @listing.listing_categories.build(category_id: params[:listing][:category])

        if @listing.save
            redirect_to @listing
        else
            render :new
        end
    end

    def show
    end

    def edit
        if !current_user
            redirect_to root_path
        end
    end

    def update
        if @listing.update(listing_params)
            redirect_to @listing
        else
            render :edit
        end
    end
    
    def destroy
        @listing.destroy
        redirect_to root_path
    end

    private
    def listing_params
        params.require(:listing).permit(:title, :price, :description, :picture)
    end

    def set_listing
        id = params[:id]
        @listing = Listing.find(id)
    end
end
