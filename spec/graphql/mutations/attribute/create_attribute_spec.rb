require 'rails_helper'

module Mutations
  module Attribute
    RSpec.describe CreateAttribute, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}
      
        context 'Params with right input' do
          let(:variables) do
            {
              input: {
                name: 'French'
              }
            }
          end

          it 'returns a Attribute' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)
            data = json['data']["createAttribute"]

            expect(data["message"]).to eq "Attribute created successfully"
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation createAttribute ($input: CreateAttributeInput!) {
            createAttribute (input: $input) {
               message
            }
        }
        GRAPHQL
      end
    end
  end
end