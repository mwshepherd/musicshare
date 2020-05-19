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

    def search
        @categories = Category.all
        @category = params[:category]
        @title = params[:title]

        if !@category.empty?
            @listings = Category.find(@category).listings.where("lower(title) LIKE :search", search: "%#{@title.downcase}%")
        else
            @listings = Listing.where("lower(title) LIKE :search", search: "%#{@title}%")
        end
    end

    def new
        @listing = Listing.new
    end

    def create
        @listing = Listing.new(listing_params)
        @listing.price *= 100
        @listing.user = current_user
        category_ids = params[:listing][:categories]

        category_ids.each do |category_id|
            @listing.listing_categories.build(category_id: category_id)
        end

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
        params[:listing][:categories] ? category_ids = params[:listing][:categories].map { |id| id.to_i } : category_ids = []
        all_categories = Category.all.map { |category| category.id }
        void_categories =  all_categories - category_ids

        if category_ids != []
            category_ids.each do |category_id|
                if @listing.listing_categories.where(category_id: category_id).empty?
                    @listing.listing_categories.create(category_id: category_id)
                end
            end
        end
        
        if void_categories != []
            void_categories.each do |category_id|
                if @listing.listing_categories.where(category_id: category_id)
                    @listing.listing_categories.where(category_id: category_id).each do |listing_category|
                        listing_category.destroy
                    end
                end
            end
        end
        
        
        if @listing.update(listing_params)
            @listing.price *= 100
            @listing.save
            redirect_to @listing
        else
            render :edit
        end
    end
    
    def destroy
        @listing.listing_categories.destroy_all
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
