module StripeIntigration
	class ConnectionsController < ApplicationController
		before_action :authentication
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
