class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]


    def get_stripe_id
        # @listing = Listing.find(params[:id])
        line_items = current_user.cart.listings.map do |listing|
            {
                name: listing.title,
                description: listing.description,
                amount: listing.price,
                currency: 'aud',
                quantity: 1,
            }
        end
        session_id = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          customer_email: current_user.email,
          line_items: line_items,
          payment_intent_data: {
            metadata: {
              user_id: current_user.id,
              cart_id: current_user.cart.id
            }
          },
          success_url: "#{root_url}payments/success?userId=#{current_user.id}&cartId=#{current_user.cart.id}",
          cancel_url: "#{root_url}listings"
        ).id
        render :json => {id: session_id, stripe_public_key: Rails.application.credentials.dig(:stripe, :public_key)}
    end

    def webhook
      payment_id= params[:data][:object][:payment_intent]
      payment = Stripe::PaymentIntent.retrieve(payment_id)
      cart_id = payment.metadata.cart_id
      user_id = payment.metadata.user_id

      p "listing id " + listing_id
      p "user id " + user_id

      head 200
    end

    def success
      create_order
      @order = current_user.orders.last
      @total = order_total
    end


    private

    def create_order
      cart = Cart.find(current_user.cart.id)
      cart.completed = true

      if cart.completed == true
        order = Order.create(user_id: current_user.id)
        #push all the items into an order table
        cart.cart_listings.each do |listing|
          listing.listing.unavailable = true
          listing.listing.save
          OrderListing.create(order_id: order.id, listing_id: listing.listing_id)
        end
        cart.cart_listings.destroy_all
      end
    end

    def order_total
      sum = 0
      @order.listings.each do |listing|
          sum += listing.price
      end
      return sum
    end
end
