require 'rails_helper'

module Queries
  module Category
    RSpec.describe FetchProductCategory, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:department) { create(:department, name: "Regional", description: "Proud of your country? Wear a T-shirt with a national symbol stamp!")}
      
        let(:category) { create(:category, name: 'French', description: 'The French have always had an eye for b', department: department)}

        let(:product) { create(:product, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }

        let(:product_category) { build(:product_category, category: category, product: product)}

        let(:variables) do { productId: product.id }  end

        before do
          product_category.save        
        end

        context "Fetch all categories" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: variables }, headers: set_token(customer)

        
            json = JSON.parse(response.body)
  
            data =  json['data']['fetchProductCategory']

            expect(data["name"]).to eq ::Category.first.name
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchProductCategory($productId: ID!) {
            fetchProductCategory(productId: $productId) {
              id
              description
              name
            }
        }
        GRAPHQL
      end
    end
  end
end