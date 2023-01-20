require 'rails_helper'

module Mutations
  module Product
    RSpec.describe CreateProduct, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}
      
        context 'Params with right input' do
          let(:variables) do
            {
              input: {
                name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99,
                discountedPrice: 0.00, 
                image: 'arc-d-triomphe.gif', image2: 'arc-d-triomphe-2.gif', 
                thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0
              }
            }
          end

          it 'returns the created product' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['data']["createProduct"]

            expect(data["description"]).to eq variables[:input][:description]
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation createProduct ($input: CreateProductInput!) {
            createProduct (input: $input) {
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