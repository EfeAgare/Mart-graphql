class WebhookController < ApplicationController
  
  def stripe

    payload = request.body.read
    endpoint_secret = ENV['stripe_endpoint_secret']

    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
        event = Stripe::Webhook.construct_event(
            payload, sig_header, endpoint_secret
        )
    rescue JSON::ParserError => e
        status 400
        return
    rescue Stripe::SignatureVerificationError => e
        status 400
        return
    end

    # Handle the event
    if event.type == 'payment_intent.created'
      payment_intent = event.data.object

      id = payment_intent.metadata.order_id.to_i

      order =  ::Order.includes(:customer).find_by(id: id)

      order.update(status: 3)

      render json: { success: "Payment successfully made" }
    end
  end
end
