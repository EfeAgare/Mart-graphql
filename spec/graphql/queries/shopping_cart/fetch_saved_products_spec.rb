require 'rails_helper'

module Queries
  module ShoppingCart
    RSpec.describe FetchSavedProducts, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:product) { create(:product, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }
      
        let(:cart_id) { ::Devise.friendly_token(10) }

        let(:shopping_cart) { build(:shopping_cart, product_id: product.id, attributes: "Nice good", cart_id: cart_id, quantity: 2, added_on: "2023-02-10", buy_now: false ) }

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
              cartId: cart_id.to_s
            }
          end

          it 'returns the created order' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['data']["fetchSavedProduct"]

            expect(data.first["cartId"]).to eq variables[:cartId]
          end
        end

        context 'Params with the wrong input' do
          let(:variables) do
            {
              cartId: 45.to_s
            }
          end

          it 'returns an error' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['data']["fetchSavedProduct"]

            expect(data).to eq []
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchSavedProduct ($cartId: String!) {
            fetchSavedProduct (cartId: $cartId) {
                attributes
                buyNow
                cartId
                id
                productId
                quantity
            }
        }
        GRAPHQL
      end
    end
  end
end
