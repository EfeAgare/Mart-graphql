require 'rails_helper'

module Mutations
  module Order
    RSpec.describe SetAuthCode, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:product) { create(:product, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }
      
        let(:cart_id) { ::Devise.friendly_token(10) }

        let(:shopping_cart) { build(:shopping_cart, product_id: product.id, attributes: "Nice good", cart_id: cart_id, quantity: 2, added_on: "2023-02-10", buy_now: true ) }

        let(:tax) { create(:tax, type: "Sales Tax at 8.5%", percentage: 8.5 ) }

        let(:shipping_region) { create(:shipping_region, region: "Nigeria") }

        let(:shipping) { create(:shipping, shipping_region_id: shipping_region.id, type: 'Next Day Delivery ($20)', cost: 20.00 ) }

        let(:order) { build(:order, tax_id: tax.id, shipping_id: shipping.id, customer_id: customer.id, total_amount: 0) }

        before do
          shopping_cart.save
          order.save
        end

        context 'Params with right input' do
          let(:variables) do
            {
              input: {
                reference: "love",
                authCode: ::Devise.friendly_token(5),
                id: order.id
              }
            }
          end

          it 'returns the updated order' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['data']["setAuthCode"]

            expect(data["quantity"]).to eq variables[:input][:quantity]
          end
        end

        context 'Params with the wrong input' do
          let(:variables) do
            {
              input: {
               reference: "love",
                authCode: ::Devise.friendly_token(5),
                id: 20
              }
            }
          end

          it 'returns an error' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['errors'].first

            expect(data["message"]).to eq "Couldn't find Order with 'id'=20"
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation setAuthCode ($input: SetAuthCodeInput!) {
            setAuthCode (input: $input) {
               id
               status
               totalAmount
            }
        }
        GRAPHQL
      end
    end
  end
end
