require 'rails_helper'

module Mutations
  module Department
    RSpec.describe CreateDepartment, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}
      
        context 'Params with right input' do
          let(:variables) do
            {
              input: {
               type: "Sales Tax at 8.5%", percentage: 8.5
              }
            }
          end

          it 'returns a tax' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)
            data = json['data']["createTax"]

            expect(data["description"]).to eq variables[:input][:description]
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation createTax ($input: CreateTaxInput!) {
            createTax (input: $input) {
               id
               type
               percentage
            }
        }
        GRAPHQL
      end
    end
  end
end