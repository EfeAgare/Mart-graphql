require 'rails_helper'

module Mutations
  module ShoppingCart
    RSpec.describe AddProduct, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:product) { create(:product, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }
      
        let(:cart_id) { ::Devise.friendly_token(10) }
        context 'Params with right input' do
          let(:variables) do
            {
              input: {
                productId: product.id,
                attributes: "Nice good",
                cartId: cart_id,
                quantity: 2,
                addedOn: "2023-02-10"
              }
            }
          end

          it 'returns the created shopping cart' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['data']["addProduct"]

            expect(data["quantity"]).to eq variables[:input][:quantity]
          end

          it 'returns the created increased shopping cart created' do

            ::ShoppingCart.create(product_id: product.id,
                attributes: "Nice good",
                cart_id: cart_id,
                quantity: 2,
                added_on: "2023-02-10")

            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data = json['data']["addProduct"]

            expect(data["quantity"]).to eq ::ShoppingCart.first.quantity
          end
        end

        context 'Params with the wrong input' do
          let(:variables) do
            {
              input: {
                productId: 48,
                attributes: "Nice good",
                cartId: ::Devise.friendly_token(10),
                quantity: 3,
                addedOn: "2023-02-10"
              }
            }
          end

          it 'returns an error' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['errors'].first

            expect(data["message"]).to eq ["Product must exist"]
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation addProduct ($input: AddProductInput!) {
            addProduct (input: $input) {
               id
               attributes
               productId
               quantity
            }
        }
        GRAPHQL
      end
    end
  end
end
