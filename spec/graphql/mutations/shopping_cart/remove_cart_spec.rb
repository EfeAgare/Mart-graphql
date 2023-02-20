require 'rails_helper'

module Mutations
  module ShoppingCart
    RSpec.describe RemoveCart, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:product) { create(:product, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }
      
        let(:cart_id) { ::Devise.friendly_token(10) }

        let(:buy_now) { true }
        let(:shopping_cart) { create(:shopping_cart, product_id: product.id, attributes: "Nice good", cart_id: cart_id, quantity: 2, added_on: "2023-02-10", buy_now: false ) }

        context 'Params with right input' do

          let(:variables) do
            {
              input: {
                cartId: shopping_cart.cart_id
              }
            }
          end

          it 'returns the update the buy now field for shopping cart' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['data']["removeCart"]

            expect(data["message"]).to eq "Cart removed successfully"
          end
        end

        context 'Params with the wrong input' do
          let(:variables) do
            {
              input: {
                cartId: 48
              }
            }
          end

          it 'returns an error' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['errors'].first

            expect(data["message"]).to eq "Cart with id=48 not found"
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation removeCart ($input: RemoveCartInput!) {
            removeCart (input: $input) {
               message
            }
        }
        GRAPHQL
      end
    end
  end
end
