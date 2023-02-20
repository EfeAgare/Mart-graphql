require 'rails_helper'

module Queries
  module Order
    RSpec.describe FetchOrderInfo, type: :request do
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

        context "Fetch a department" do
           let(:variables) do
            {
              customerId: customer.id
            }
          end
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: variables }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchCustomerOrders']

            expect(data.last["status"]).to eq ::Order.last.status
          end
        end
      end

      def query
        <<~GRAPHQL
         query fetchCustomerOrders ($customerId: ToInt!) {
          fetchCustomerOrders (customerId: $customerId) {
            comments
            id
            shippingId
            status
            taxId
            totalAmount
          }
        }
        GRAPHQL
      end
    end
  end
end