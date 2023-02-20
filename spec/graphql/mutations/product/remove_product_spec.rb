require 'rails_helper'

module Mutations
  module Product
    RSpec.describe RemoveProduct, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}
      
        let(:product) { build(:product, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }

        before do
          product.save
        end

        context 'Params with right input' do
          let(:variables) do
            {
              input: {
                id: product.id
              }
            }
          end

          it 'returns the created product' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['data']["removeProduct"]

            expect(data["message"]).to eq "Poduct deleted successfully"
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation removeProduct ($input: RemoveProductInput!) {
            removeProduct (input: $input) {
               message
            }
        }
        GRAPHQL
      end
    end
  end
end