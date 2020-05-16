class PaymentsController < ApplicationController
    def get_stripe_id
        # @listing = Listing.find(params[:id])
        @line_items = current_user.cart.listings.map { |listing|
            {
                name: listing.title,
                description: listing.description,
                amount: listing.price,
                currency: 'aud',
                quantity: 1,
            }
        }
        session_id = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          customer_email: current_user.email,
          #Line items needs to be the array of items in the cart
          line_items: @line_items,
          payment_intent_data: {
            metadata: {
              user_id: current_user.id,
              cart_id: current_user.cart.id #this needs to change
            }
          },
          success_url: "#{root_url}payments/success?userId=#{current_user.id}&cartId=#{current_user.cart.id}",
          cancel_url: "#{root_url}listings"
        ).id
        render :json => {id: session_id, stripe_public_key: Rails.application.credentials.dig(:stripe, :public_key)}
    end

    def webhook
      puts
      puts '*' * 30
      p params
      puts '*' * 30
      puts

      payment_id= params[:data][:object][:payment_intent]
      payment = Stripe::PaymentIntent.retrieve(payment_id)
      listing_id = payment.metadata.listing_id
      user_id = payment.metadata.user_id

      p "listing id " + listing_id
      p "user id " + user_id

      head 200
    end

    def success
    end
end
