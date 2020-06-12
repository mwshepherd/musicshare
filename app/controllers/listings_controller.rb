class ListingsController < ApplicationController
    before_action :set_listing, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]
    load_and_authorize_resource

    def index
    end

    def browse
        # Retrieving all listings from the database which include a user, categories and with a picture attached
        @listings = Listing.includes(:user, :categories).all.with_attached_picture
        # Returning an array of all categories to display a list in the browse view or filtering
        @categories = Category.all
        @category = params[:category]
        if @category.present?
            # Will only retreive listings if a category param is present and will update the view based on the category
            @listings = Category.find(@category).listings
        end
    end

    def search
        # Returning an array of all categories to display a list in the browse view or filtering
        @categories = Category.all
        @category = params[:category]
        @title = params[:title]

        if !@category.empty?
            # If a category is present in the search, it will search for listings with the keywords given within the given category
            @listings = Category.find(@category).listings.where("lower(title) LIKE :search", search: "%#{@title.downcase}%")
        else
            # If no category is present in the search, it will search through all listings
            @listings = Listing.where("lower(title) LIKE :search", search: "%#{@title}%")
        end
    end

    def new
        # Opens a new listing ready for creation - it will be saved in the create method
        @listing = Listing.new
    end

    def create
        # Opens a new listing ready for creation - it will be saved in the create method
        @listing = Listing.new(listing_params)
        @listing.price *= 100
        @listing.user = current_user
        category_ids = params[:listing][:categories]

        # If a category has been selected upon creating, it will add the category to the listing
        if category_ids != nil
            category_ids.each do |category_id|
                @listing.listing_categories.build(category_id: category_id)
            end
        end

        if @listing.save
            redirect_to @listing
        else
            render :new
        end
    end

    def show
        @location = Location.where(listing_id: params[:id])
        if params[:type] == "json"
            render json: {data: [@location.latitude, @location.longitude]}
        end
    end

    def edit
        if !current_user
            redirect_to root_path
        end
    end

    def update
        # If no categories are passed through params, category ids will be an empty array
        params[:listing][:categories] ? category_ids = params[:listing][:categories].map { |id| id.to_i } : category_ids = []
        # Creates an array of all category ids
        all_categories = Category.all.map { |category| category.id }
        # Determinds which categories are to be removed
        void_categories =  all_categories - category_ids

        # If a new category has been added upon updating it will add that category to the listing
        if category_ids != []
            category_ids.each do |category_id|
                if @listing.listing_categories.where(category_id: category_id).empty?
                    @listing.listing_categories.create(category_id: category_id)
                end
            end
        end
        
        # If there are void categories present it will remove them from the current listing upon updating
        if void_categories != []
            void_categories.each do |category_id|
                if @listing.listing_categories.where(category_id: category_id)
                    @listing.listing_categories.where(category_id: category_id).each do |listing_category|
                        listing_category.destroy
                    end
                end
            end
        end
        
        # If the listiing is updated, it will convert the price to cents, save and redirect to the listing
        if @listing.update(listing_params)
            @listing.price *= 100
            @listing.save
            redirect_to @listing
        else
            render :edit
        end
    end
    
    def destroy
        # Will delete the listing along with its listing_categories tables
        @listing.listing_categories.destroy_all
        @listing.destroy
        redirect_to browse_path
    end

    private
    def listing_params
        # Permits params to be used for creating and updating listings
        params.require(:listing).permit(:title, :price, :description, :picture)
    end

    def set_listing
        id = params[:id]
        # Will retreive the listing based on the id provided in the params
        @listing = Listing.find(id)
    end
end
