require 'rails_helper'

module Mutations
  module Product
    RSpec.describe CreateProductReview, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:product) { create(:product, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }

        let(:review) { create_list(:review, 4, customer: customer,product: product, review: "Nice good", rating: 3)}
      
        context 'Params with right input' do
          let(:variables) do
            {
              input: {
                customerId: customer.id,
                productId: product.id,
                review: "Nice good",
                rating: 3
              }
            }
          end

          it 'returns the created product revioew' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)
  
            data = json['data']["createProductReview"]

            expect(data["rating"]).to eq variables[:input][:rating]
          end
        end

        context 'Params with the wrong input' do
          let(:variables) do
            {
              input: {
                customerId: 44,
                productId: product.id,
                review: "Nice good",
                rating: 3
              }
            }
          end

          it 'returns an error' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['errors'].first

            expect(data["message"]).to eq ["Customer must exist"]
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation createProductReview ($input: CreateProductReviewInput!) {
            createProductReview (input: $input) {
               review
               rating
            }
        }
        GRAPHQL
      end
    end
  end
end