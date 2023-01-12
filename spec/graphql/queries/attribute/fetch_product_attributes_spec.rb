require 'rails_helper'

module Queries
  module Attribute
    RSpec.describe FetchProductAttributes, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:attribute) { create(:attribute, name: "Regional")}

        let(:attribute_values) { create_list(:attribute_value, 3, value: "Regional", attribute_id: attribute.id)}
      
        let(:product) { create(:product, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }

        let(:product_attribute) { build(:product_attribute, product: product, attribute_value: attribute_values.first) }

        let(:variables) do { productId: product.id }  end

        before do
          product_attribute.save
        end

        context "Fetch ProductAttributes" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: variables }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchProductAttributes']

            expect(data["attributeValue"]['value']).to eq ::AttributeValue.first.value
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchProductAttributes($productId: ID!) {
            fetchProductAttributes(productId: $productId) {
              id
              attributeValue {
                id
                value
              }
            }
        }
        GRAPHQL
      end
    end
  end
end