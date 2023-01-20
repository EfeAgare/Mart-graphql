require 'rails_helper'

module Queries
  module Product
    RSpec.describe FetchAllProducts, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

         let(:product) { create_list(:product, 4, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }
      
        before do
          product.map(&:save)
        end

        context "Fetch all products" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchAllProducts']

            expect(data['products'].length).to eq 4
            expect(data['products'].first["name"]).to include product.first.name.as_json
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchAllProducts {
            fetchAllProducts {
              products {
                id
                name
                description
                price
                discountedPrice
                image
                image2
                thumbnail
              }
              totalPages
              count
            }
        }
        GRAPHQL
      end
    end
  end
end