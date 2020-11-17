class PaymentsController < ApplicationController
    before_action :authenticate_user!, except: [:webhook]
    skip_before_action :verify_authenticity_token, only: [:create, :webhook]
  
    def create 
      item = Item.find(params[:id])
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          price_data: {
            unit_amount: item.price*100,
            currency: 'aud',
            product_data: {
              name: item.name
            },
          },
          quantity: 1,
        }],
        mode: 'payment',
        success_url: "#{root_url}payments/success?item_id=#{item.id}",
        cancel_url: "#{root_url}payments/cancel"
      })
      render json: { id: session.id }
    end
  
    def webhook 
      endpoint_secret = Rails.application.credentials.dig(:stripe, :endpoint_secret)
      begin
        sig_header = request.env['HTTP_STRIPE_SIGNATURE']
        payload = request.body.read
        event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
      rescue JSON::ParserError => e
        # Invalid payload
        head 400
      rescue Stripe::SignatureVerificationError => e
        # Invalid signature
        head 400
      end
      case event['type']
      when 'checkout.session.completed'
        checkout_session = event['data']['object']
        # write to the database to confirm that an item has actually been sold 
      when 'checkout.session.async_payment_failed'
        # write to the database that an item is still available
        # reach out to the customer to say that the payment was unsuccessful
      end
    end
    
    def success
      @item = Item.find(params[:item_id])
    end
  
    def cancel 
    end

end
