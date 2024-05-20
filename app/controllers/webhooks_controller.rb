class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session # Disable CSRF protection for webhook endpoints
  
  def stripe
    debugger
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = 'whsec_5eee53bdf3b5511aec6f4a190cbe6d96d714696f38e55064897a027cf4e9beeb' # Replace with your actual webhook secret
    
    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
      handle_payment(event)
    rescue JSON::ParserError => e
      # Invalid payload
      render status: :bad_request, json: { error: "Invalid payload" }
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      render status: :bad_request, json: { error: "Invalid signature" }
      return
    end
  end

  private


  def handle_payment(event)
    debugger
    # Handle the event based on its type
    case event.type
    when 'payment_intent.succeeded'
      handle_payment_intent_succeeded(event)
    when 'payment_intent.failed'
      handle_payment_intent_failed(event)
    # Add other event types to handle as needed
    when 'charge'
      handle_charge_event(event)
    else
      puts "Unhandled event type: #{event.type}"
    end
    render status: :ok, json: { message: "Received" }
  end

  def handle_charge_event(event)
    #transaction.upadate(status: event.data.status)
  end

  def handle_payment_intent_succeeded(event)
    payment_intent = event.data.object
    # Update payment status in your database based on payment_intent
    # Example: Payment.find_by(stripe_payment_intent_id: payment_intent.id).update(status: 'succeeded')
  end

  def handle_payment_intent_failed(event)
    payment_intent = event.data.object
    # Update payment status in your database based on payment_intent
    # Example: Payment.find_by(stripe_payment_intent_id: payment_intent.id).update(status: 'failed')
  end
end
