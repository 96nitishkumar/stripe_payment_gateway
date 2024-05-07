module StripeIntigration
	class RefundsController < ApplicationController
		before_action :authentication
		def payment_refound_with_payment_intent
    	payment_intent_id = params[:payment_intent_id]
    	amount_to_refund = params[:amount]
    	begin
    	  payment_intent = Stripe::PaymentIntent.retrieve(payment_intent_id)
	
    	  refund = Stripe::Refund.create({
    	    payment_intent: payment_intent_id,
    	    amount: amount_to_refund, 
    	  })
    	  if refund.status == 'succeeded'
    	    render json: { success: true, refund: refund }
    	  else
    	    render json: { error: 'Refund failed', message: refund.failure_reason }
    	  end
    	rescue Stripe::StripeError => e
    	  render json: { error: 'Refund failed', message: e.message }
    	end
  	end

  	def refund_amount_with_charge
  		begin
  			refund = Stripe::Refund.create({
  			  charge: params[:charge_id],
  			  # amount: params[:amount],
  			  reason: "requested_by_customer",
  			},{
  			stripe_account: "acct_1PBwx2FxtyX1sWwD"
  			})

  			if refund.status == 'succeeded'
  			  render json: { success: true, refund: refund }
  			else
  			  render json: { error: 'Refund failed', message: refund.failure_reason }
  			end
			rescue Stripe::StripeError => e
			  render json: { error: 'Refund failed', message: e.message }
			end
  	end


  	# def refund_amount_with_charge
  	# 	# begin
  	# 		refund = Stripe::Refund.create({
  	# 		  charge: "ch_3PC033FsFqF9fJAD0vX6K7b2",
  	# 		  # amount: params[:amount],
  	# 		  reason: "requested_by_customer"
  	# 		})

  	# 		if refund.status == 'succeeded'
  	# 		  render json: { success: true, refund: refund }
  	# 		else
  	# 		  render json: { error: 'Refund failed', message: refund.failure_reason }
  	# 		end
		# 	# rescue Stripe::StripeError => e
		# 	#   render json: { error: 'Refund failed', message: e.message }
		# 	# end
  	# end
	end
end
