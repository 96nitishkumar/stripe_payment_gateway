module StripeIntigration
	class PaymentIntentsController < ApplicationController
		include PaymentBlock::CustomerPayment
		# before_action :authentication
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
	  		    transfer_data: {
	  		    	account: "acct_1PHd1KQH6eriu07E"
	  		    }
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


		def create_payment_int
			payment_details = {
  		    amount: 1200,                        # Amount in cents
  		    currency: "usd",
  		    payment_method_types: ["card"],
  		    payment_method_data: {
  		      type: 'card',
  		      card: {
  		        token: "tok_visa"
  		      }
  		    },
  		    confirm: true,
  		  }

  		  payment_intent = create_payment_intent_a(payment_details)
  		   render json: { payment_intent: payment_intent }

		end


		def create_charge_pay
			payment_details = {
	  		    amount: 1300,                        # Amount in cents
	  		    currency: "usd",
	  		    source: "tok_visa",
	  		    description: "Product price payment",
	  		    transfer_data:{
	  		    	destination: "acct_1PHd1KQH6eriu07E" # product belongs to which vender that connect Account id 
	  		    	amount: 200 # Transfer amount to paricular vender account if amount is not mention that time by default taken above all amount
	  		    	#if amount is give in transfer data that amount(200) is go to particular vender and amount(1300) goes to main stripe account
	  		    	#in this the flow of application is first it all amount(1300) send to the Stripe dashboad and again from there it send amount
	  		    	# 200 to the vender or paticular connected account in this flow is
	  		    	# customer => main stripe dashboard => connected account(vender account)
	  		    } 

  		  	}
  		  charge = process_charge(payment_details)
  		  render json: { payment_intent: charge }

		end
	end
end
