module PaymentBlock
	
	module CustomerPayment

		def process_charge(payment_details)
			begin
        # Create a charge using the Charges API
        Stripe::Charge.create({
          amount: payment_details[:amount],
          currency: payment_details[:currency],
          source: payment_details[:source], # Payment source (e.g., card token)
          description: payment_details[:description],
          transfer_data: payment_details[:transfer_data]
        })
      rescue Stripe::StripeError => e
        # Handle error (e.g., log, notify admin, etc.)
        puts "Error processing charge: #{e.message}"
        return nil
      end
		end

		def create_payment_intent_a(payment_details)
			begin
        # Create a Payment Intent using the Payment Intents API
        Stripe::PaymentIntent.create({
          amount: payment_details[:amount],
          currency: payment_details[:currency],
          payment_method_types: payment_details[:payment_method_types], # Array of accepted payment methods
        	payment_method_data: payment_details[:payment_method_data],
          transfer_data:payment_details[:transfer_data]
        })
      rescue Stripe::StripeError => e
        # Handle error (e.g., log, notify admin, etc.)
        puts "Error creating payment intent: #{e.message}"
        return nil
      end
    end

    def create_payment_method(card_details)
      Stripe::PaymentMethod.create({
        type: "card",
        card: {
          number: "424242424242424242",
          exp_month: "09",
          exp_year: "2027",
          "cvv": "123"
        }

      })


    end

    # Add other payment-related methods here as needed
	end 
end