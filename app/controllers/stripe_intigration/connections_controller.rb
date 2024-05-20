module StripeIntigration
	class ConnectionsController < ApplicationController
		# before_action :authentication

    def index 

    end

		def create_connections
      # @user = User.find(params[:id])
      file = File.new(params[:my_document])
      file_upload = Stripe::File.create(purpose: "identity_document", file: file)
      
      stripe_params = {
        type: 'custom',
        business_type: "individual",
        email: params[:email],
        individual: {
          verification: {
            document: {
              front: file_upload.id
            }
          },
          first_name: params[:first_name],
          last_name: params[:last_name],
          phone: params[:phone_number],
          email: params[:email],
          dob: {
            day: params[:dob_day],
            month: params[:dob_month],
            year: params[:dob_year]
          },
          address: {
            line1: params[:address_line1],
            city: params[:address_city],
            state: params[:address_state],
            postal_code: params[:address_postal_code],
            country: params[:address_country]
          },
        },
        business_profile: {
          mcc: params[:mcc],
          name: params[:business_name],
          url: params[:business_url],
        },
        country: params[:country],
        external_account: {
          object: "bank_account",
          routing_number: params[:routing_number],
          country: params[:external_country],
          currency: params[:external_currency],
          account_holder_name: params[:account_holder_name],
          account_number: params[:account_number],
        },
        capabilities: {
          card_payments: { requested: true },
          transfers: { requested: true },
          bank_transfer_payments: { requested: true }
        },
        tos_acceptance: {
          date: Time.now.to_i,
          ip: params[:ip]
        }
      }
      stripe = Stripe::Account.create(stripe_params)
      render json: { stripe: stripe,message:"Connection created" }
    end
	end
end


# for account dashboard of businner owner 

# import stripe

# stripe.api_key = "your_platform_secret_key"

# # Create an account link for the hotel to connect their Stripe account
# account_link = stripe.AccountLink.create(
#     account="hotel_stripe_account_id",
#     refresh_url="https://yourapplication.com/reauth",
#     return_url="https://yourapplication.com/return",
#     type="account_onboarding",
# )


# processing payment from customer to connected stripe account


#  payment_intent = stripe.PaymentIntent.create(
#     amount=total_amount,
#     currency="usd",
#     payment_method_types=["card"],
#     transfer_data={
#         "destination": "hotel_stripe_account_id",
#     },
# )

# Processing Payments with Application Fee:

# payment_intent = stripe.PaymentIntent.create(
#     amount=total_amount,
#     currency="usd",
#     payment_method_types=["card"],
#     application_fee_amount=application_fee_amount,  # Fee your application charges
#     transfer_data={
#         "destination": "hotel_stripe_account_id",  # Hotel's Stripe account ID
#     },
# )


# Handling Stripe Fees:

# Stripe will automatically deduct its fees before transferring the 
# net amount to the connected account (hotel's Stripe account). 
# Your application doesn’t need to handle Stripe fees separately; 
# Stripe manages it internally.


# Customer Books Room:

# Payment is processed through Stripe.
# Total amount: $100
# Application fee: $10 (deducted from the total amount and transferred to your platform account)
# Stripe fee: $2.90 (Stripe deducts this fee from the total amount, typically a percentage plus a fixed amount)
# Net amount transferred to the hotel's account: $87.10


#Code Example for Payment Intent with Application Fee:

#   import stripe

# stripe.api_key = "your_platform_secret_key"

# Assuming these values are dynamically set based on the booking
# total_amount = 10000  # in cents ($100)
# application_fee_amount = 1000  # in cents ($10)
# hotel_stripe_account_id = "acct_xxxxxxxxxxxxxx"

# Create the payment intent with application fee
# payment_intent = stripe.PaymentIntent.create(
#     amount=total_amount,
#     currency="usd",
#     payment_method_types=["card"],
#     application_fee_amount=application_fee_amount,
#     transfer_data={
#         "destination": hotel_stripe_account_id,
#     },
# )



#Implementation Details

#Hotel Initiates Refund via Stripe Dashboard:

# The hotel owner can log into their Stripe dashboard, find the payment, and issue a refund. Stripe provides an option to refund the application fee during this process.
# Hotel Initiates Refund via Stripe API:

# If the refund is processed programmatically, the hotel uses the Stripe API to issue the refund. Here's how to do it:


# Example Code for Full Refund Including Application Fee

# import stripe

# Use the hotel's secret key to authenticate
# stripe.api_key = "hotel_owner_secret_key"

# Assuming you have the payment intent ID
# payment_intent_id = "pi_xxxxxxxxxxxxxx"

# Retrieve the charge ID from the payment intent
# payment_intent = stripe.PaymentIntent.retrieve(payment_intent_id)
# charge_id = payment_intent.charges.data[0].id

# Create a refund and refund the application fee as well
# refund = stripe.Refund.create(
#     charge=charge_id,
#     refund_application_fee=True,
#     reverse_transfer=True
# )

# Key Parameters:
# refund_application_fee: This parameter ensures that the application fee is also refunded to the customer.
# reverse_transfer: This parameter reverses the transfer that was made to the connected account (hotel's Stripe account), ensuring the funds are returned from the hotel's account.


# Full Workflow:
# Customer Books Room:

# Payment processed through Stripe.
# Total amount: $100
# Application fee: $10
# Stripe fee: $2.90
# Net amount transferred to the hotel's account: $87.10
# Customer Requests Refund:

# Hotel initiates a full refund.
# Refund Process:

# Hotel issues a refund via the Stripe dashboard or API.
# Full amount ($100) is refunded to the customer.
# Application fee ($10) is refunded.
# Stripe reverses the transfer to the hotel's account, deducting $87.10.
# Stripe Fees:

# Stripe may retain the original processing fees ($2.90) based on their policy. However, in some cases, Stripe refunds the processing fee as well.
# Benefits:
# Customer Satisfaction: The customer receives a full refund, including the application fee, ensuring a fair and transparent process.
# Automated Management: Using Stripe's API ensures that refunds, including application fees and reverse transfers, are handled automatically and correctly.
# Clear Financial Records: Both the application and the hotel maintain clear records of transactions and refunds, facilitating better financial management.
# By following these steps, you can implement a robust refund process where hotel owners can offer full refunds to customers, including the application fee, ensuring a seamless experience for both the hotel owners and the customers.