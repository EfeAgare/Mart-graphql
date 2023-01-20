require 'rails_helper'

module Queries
  module Product
    RSpec.describe FetchProductReviews, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:product) { create(:product, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }

        let(:review) { create_list(:review, 4, customer: customer,product: product, review: "Nice good", rating: 3)}
      
        before do
          review.map(&:save)
        end

        context "Fetch product reviews" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: {productId: product.id} }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchProductReviews']

            expect(data.first["review"]).to eq review.first.review.as_json
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchProductReviews($productId: ID!) {
            fetchProductReviews(productId: $productId){
              id
              review
              rating
              customer {
                id
                name
              }
          
            }
        }
        GRAPHQL
      end
    end
  end
end