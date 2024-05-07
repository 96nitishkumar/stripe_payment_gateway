module StripeIntigration
	class PaymentIntentsController < ApplicationController
		before_action :authentication
		def payment_intent
  		payment_method_token = params[:payment_method_token]
  
  		begin
  		  payment_intent = Stripe::PaymentIntent.create({
  		    amount: 1000,                        # Amount in cents
  		    currency: "usd",
  		    payment_method_types: ["card"],
  		    payment_method_data: {
  		      type: 'card',
  		      card: {
  		        token: "tok_visa"
  		      }
  		    },
  		    confirm: true,
  		  })
		
  		  if payment_intent.status == 'succeeded'
  		    render json: { data: payment_intent }
  		  else
  		    render json: { error: 'Payment failed', message: payment_intent.last_payment_error, payment_intent: payment_intent }
  		  end
  		rescue Stripe::CardError => e
  		  render json: { error: 'Payment failed', message: e.message }
  		end
		end
	end
end
