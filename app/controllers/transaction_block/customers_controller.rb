module TransactionBlock
	class CustomersController < ApplicationController
		before_action :authentication

		def create_customer
			customer = Stripe::Customer.create({
  			name:@current_user.name,
  			email: @current_user.email
			})
			render json:{data: customer}
		end

		def add_card
  		card = Stripe::Customer.create_source(@current_user.stripe_id, {source: {object: 'card',number: params[:card_number], exp_month: params[:exp_month], exp_year: params[:exp_year], last4: params[:last4]}})
  		rescue StandardError => e
  		card = Stripe::Customer.create_source(@current_user.stripe_id, {source: params[:card]})
  		render json:{data:card}
		end

		def user_cards
      cards = Stripe::Customer.list_sources(@current_user.stripe_id,{object:'card'})  
      render json:{cards:cards,message:"cards fetched successfully"},status:200    
		end

		def create_pament_method
			payment_method = Stripe::PaymentMethod.create({
  			type: 'card',
  			card: {
    			number: '4242424242424242',
    			exp_month: 8,
    			exp_year: 2026,
    			cvc: '314',
  			},
			})
		rescue StandardError => e
			render json:{data:payment_method,error: e.message}
		end

  	def payment_check_out
  		checkout = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [
         {
            price_data: {
             currency: 'inr',
             product_data: {
               name: 'I Phone',
               description: 'Electronic device'
             },
             unit_amount: 15000000,
           },
           quantity: 1
          }
        ],
        mode: 'payment',
   			success_url: 'http://127.0.0.1:3000/transaction_block/success',
   			cancel_url: 'http://127.0.0.1:3000/transaction_block/fail'
 			)
   		render json:{data:checkout.url}
  	end

  	def stripe_payment
			# render 'users/stripe'
			pdf = WickedPdf.new.pdf_from_string(render_to_string('users/form'))
  	save_path = Rails.root.join('simple.pdf')
  	File.open(save_path,'wb') do |file|
  		file<<pdf
  	end
		end

		def success
			render 'users/success'
		end
		def fail
			render 'users/fail'
		end
	end
end

