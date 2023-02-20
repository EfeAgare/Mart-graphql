require 'rails_helper'

module Mutations
  module ShoppingCart
    RSpec.describe UpdateCartQuantity, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:product) { create(:product, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }
      
        let(:cart_id) { ::Devise.friendly_token(10) }

        let(:shopping_cart) { build(:shopping_cart, product_id: product.id, attributes: "Nice good", cart_id: cart_id, quantity: 2, added_on: "2023-02-10", buy_now: true ) }

        before do
          shopping_cart.save
        end

        context 'Params with right input' do
          let(:variables) do
            {
              input: {
                cartId: cart_id,
                quantity: 5
              }
            }
          end

          it 'returns the created shopping cart' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['data']["updateCartQuantity"]

            expect(data["message"]).to eq "Cart quantity updated"
          end
        end

        context 'Params with the wrong input' do
          let(:variables) do
            {
              input: {
                cartId: "yythgbujk",
                quantity: 4
              }
            }
          end

          it 'returns an error' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['errors'].first

            expect(data["message"]).to eq "Cart with id=yythgbujk not found"
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation updateCartQuantity ($input: UpdateCartQuantityInput!) {
            updateCartQuantity (input: $input) {
              message
            }
        }
        GRAPHQL
      end
    end
  end
end
