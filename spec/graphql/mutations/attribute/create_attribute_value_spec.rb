require 'rails_helper'

module Mutations
  module Attribute
    RSpec.describe CreateAttributeValue, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:attribute) { create(:attribute, name: "Regional")}

        context 'Params with right input' do
          let(:variables) do
            {
              input: {
                value: 'French', attributeId: attribute.id
              }
            }
          end

          it 'returns a Attribute value' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)
            data = json['data']["createAttributeValue"]
  
            expect(data["message"]).to eq "Attribute value created successfully"
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation createAttributeValue ($input: CreateAttributeValueInput!) {
            createAttributeValue (input: $input) {
               message
            }
        }
        GRAPHQL
      end
    end
  end
end