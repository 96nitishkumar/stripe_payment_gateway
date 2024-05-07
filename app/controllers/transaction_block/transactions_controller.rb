module TransactionBlock
	class TransactionsController < ApplicationController
		before_action :authentication
		before_action :set_transaction, only: [:update]

		def update
			@transaction.update(paid_amount:params[:paid_amount])
			if @transaction.total_amount == params[:paid_amount]
				@transaction.update(transaction_status:"Success")
				payment(@transaction.total_amount)
				render json:{data: @transaction, message: "transaction completed"}
			else
				@transaction.update(transaction_status: "Reject")
				render json: {data: @transaction, message: "oops!...Your transaction rejected, check yout transaction details"}
			end
		end

		def user_transactions
			paid_transactions = @current_user.transactions.sum(:total_amount)
			refund_transactions = @current_user.transactions.sum(:refund)
			total_transaction = paid_transactions - refund_transactions
			render json:{data:total_transaction, message:'user total transactions'}
		end

		def owner_ernings
			rooms_ids = @current_user.rooms.ids
			booking_ids = Booking.where(id:rooms_ids).ids
			transactions = TransactionBlock::Transaction.where(user_id:@current_user.id, booking_id: booking_ids, status:"Success").sum(:total_amount)
			render json: {data: transactions, message: "Total earnings"}
		end

		def payment(amount)
			Stripe::PaymentIntent.create({
  			amount: amount.to_i,
  			currency: 'INR',
  			# source: 
  			payment_method_types: ['card'],
  			payment_method: 'card_1OrwOBSIXVynxldOHjuxPYg5',
  			customer: 'cus_PhKueM9FRGIzAW',
  			 confirmation_method: 'manual'
  			  status: 'requires_confirmation'
  			# confirm:true
 				# automatic_payment_methods: {enabled: true}
			})
		end

		def capture
			Stripe.api_key =  ENV["STRIPE_SECRET_KEY"]
			begin
  			intent = Stripe::PaymentIntent.retrieve(params[:payment_id])
  			if intent.status == 'requires_capture'
    			intent.capture
    			intent.confirm
					# Stripe::PaymentIntent.capture(params[:payment_id])
  			end
			rescue Stripe::InvalidRequestError => e
  			intent= "Error capturing PaymentIntent: #{e.message}"
			end
			# render json:{data: intent}
		end

		def set_transaction
			@transaction = @current_user.transactions.find(params[:id])
		end
	end
end
