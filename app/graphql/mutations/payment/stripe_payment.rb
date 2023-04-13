module Mutations
  class Payment::StripePayment < Mutations::BaseMutation
    argument :order_id, ID, required: true
    argument :currency, String, required: true

    field :client_secret, String, null: false

    def resolve(**params)
       begin 
          if params[:order_id].blank?
            bad_request("params cannot be empty")
          else
            order = order_summary(params)

            if order&.paid?
              conflict('Payment has been made for this order')
            else
              stripe_payment(order, params)
            end
          end
      rescue Stripe::CardError => e
        raise GraphQL::ExecutionError.new(
        e.error.type, options: {  message: e.message,  status: e.http_status, TYPE: e.error.type, ChargeID: e.error.charge })
      end
    end

    def current_user
      context[:current_user]
    end

    def stripe_payment(order, params)

      customer = Stripe::Customer.create({
        email: current_user.email
      })

      payment_intent = Stripe::PaymentIntent.create({
        customer: customer.id,
        amount: order.total_amount.to_i * 100,
        description: "Charge for #{current_user.email}",
        currency: params[:currency],
        automatic_payment_methods: {enabled: true},
        metadata: {order_id: params[:order_id]},
      })

      {client_secret: payment_intent.client_secret }
    
    end

    def order_summary(params)
      ::Order.includes(:customer).find_by(id: params[:order_id])
    end
  end
end
