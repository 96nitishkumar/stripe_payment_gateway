module Payment
	


	def self.send_amount_to_connections(total_amount,owner)
		total_amount = total_amount*100
    	commission_amount = (total_amount * 0.2).to_i
    	amount_to_hotel_owner = total_amount - commission_amount	
    	charge = Stripe::Charge.create({
    	  amount: total_amount,
    	  currency: 'usd',
    	  source: "tok_visa",
    	  description: 'Hotel booking charge',
    	  transfer_data: {
    	  	amount: amount_to_hotel_owner,
    	    destination:owner.stripe_connect_id
    	  }
    	})
    	if charge.paid
    		return charge
    	else
    		return "Payment failed"
    	end
  	rescue Stripe::CardError => e
  	render json:{message:"Payment failed."},status:200 
  end


  def send_amount_to_connections(total_amount, owner)
	  total_amount = total_amount * 100
	  commission_amount = (total_amount * 0.2).to_i
	  amount_to_hotel_owner = total_amount - commission_amount
	  charge = Stripe::Charge.create({
	    amount: total_amount,
	    currency: 'usd',
	    source: "tok_visa",
	    description: 'Hotel booking charge'
	  })
	  if charge.paid
	    transfer_amount_to_owner(amount_to_hotel_owner, owner.stripe_connect_id)
	    return charge
	  else
	    return "Payment failed"
	  end
		rescue Stripe::CardError => e
	  render json: { message: "Payment failed." }, status: 200
	end

	def transfer_amount_to_owner
	  transfer = Stripe::Transfer.create({
	    amount: amount,
	    currency: 'usd',
	    destination: destination
	  })
	  
	  if transfer.status == 'paid'
	    puts "Amount transferred successfully to hotel owner."
	  else
	    puts "Transfer failed."
	  end
	end



  # def self.send_amount_to_connections(total_amount, owner)
	#   total_amount = total_amount * 100
	#   commission_amount = (total_amount * 0.2).to_i
	#   amount_to_hotel_owner = total_amount - commission_amount

	#   # delayed_date = (Time.now + 2.days).to_i
	#   delayed_timestamp = (Time.now + 2.minutes).to_i
	
	#   charge = Stripe::Charge.create({
	#     amount: total_amount,
	#     currency: 'usd',
	#     source: "tok_visa",
	#     description: 'Hotel booking charge',
	#     transfer_data: {
	#       amount: amount_to_hotel_owner,
	#       destination: owner.stripe_connect_id,
	#       transfer_schedule: {
	#         delay_days: 0, 
  #       	delay_hours: 0,
  #       	delay_minutes: 2
	#       }
	#     }
	#   })
	
	#   if charge.paid
	#     return charge
	#   else
	#     return "Payment failed"
	#   end
	# 	rescue Stripe::CardError => e
	#   render json: { message: "Payment failed." }, status: 200
	# end


# 	def self.send_amount_to_connections(total_amount, owner)
#   total_amount = total_amount * 100
#   commission_amount = (total_amount * 0.2).to_i
#   amount_to_hotel_owner = total_amount - commission_amount

#   charge = Stripe::Charge.create({
#     amount: total_amount,
#     currency: 'usd',
#     source: "tok_visa",
#     description: 'Hotel booking charge',
#   })

#   if charge.paid
#     transfer = Stripe::Transfer.create({
#       amount: amount_to_hotel_owner,
#       currency: 'usd',
#       destination: owner.stripe_connect_id,
#       transfer_schedule: {
#         delay_days: 0,
#         delay_hours: 0,
#         delay_minutes: 2
#       }
#     })

#     return charge
#   else
#     return "Payment failed"
#   end
# rescue Stripe::CardError => e
#   render json: { message: "Payment failed." }, status: 200
# end


# 	def self.payment_intent_connections(total_amount, owner)
#   total_amount = total_amount * 100
#   commission_amount = (total_amount * 0.2).to_i
#   amount_to_hotel_owner = total_amount - commission_amount
#   payment_intent = Stripe::PaymentIntent.create({
#     amount: total_amount,
#     currency: 'usd',
#     payment_method_types: ['card'],
#     payment_method: "tok_visa", # Attaching payment method
#     transfer_data: {
#       amount: amount_to_hotel_owner,
#       destination: owner.stripe_connect_id
#     }
#   })
#   Stripe::PaymentIntent.confirm(payment_intent.id)
#   if payment_intent.status == 'succeeded'
#     return payment_intent
#   else
#     return "Payment failed"
#   end
# rescue Stripe::CardError => e
#   return "Payment failed"
# end

end