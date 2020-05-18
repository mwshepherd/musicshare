class ProfilesController < ApplicationController
    def index
        @user = User.where(username: params[:username])[0]
    end

    def orders
        @orders = current_user.orders
    end
end
