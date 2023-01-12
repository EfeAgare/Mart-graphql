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
                name: 'French', description: 'The French have always had an eye for b'
              }
            }
          end

          it 'returns a department' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)
            data = json['data']["createDepartment"]

            expect(data["description"]).to eq variables[:input][:description]
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation createDepartment ($input: CreateDepartmentInput!) {
            createDepartment (input: $input) {
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