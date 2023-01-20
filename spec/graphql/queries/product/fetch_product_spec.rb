require 'rails_helper'

module Queries
  module Product
    RSpec.describe FetchProduct, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

         let(:product) { create_list(:product, 4, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }
      
        before do
          product.map(&:save)
        end

        context "Fetch product" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: { id: product.first.id } }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchProduct']

            expect(data["name"]).to include product.first.name.as_json
          end
        end

        context "Fetch product that does exist" do
          let(:id) { 344 }
      
          it 'returns a not found error' do

            post '/graphql', params: { query: query, variables: { id: id } }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['errors'][0]

            expect(data["message"]).to eq "Couldn't find Product with 'id'=#{id}"
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchProduct($id: ID!) {
            fetchProduct(id: $id) {
              id
              name
              description
              price
              discountedPrice
              image
              image2
              thumbnail
            }
        }
        GRAPHQL
      end
    end
  end
end