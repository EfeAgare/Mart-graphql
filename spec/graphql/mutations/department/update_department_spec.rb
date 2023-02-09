require 'rails_helper'

module Mutations
  module Department
    RSpec.describe UpdateDepartment, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:department) { create(:department, name: "Regional", description: "Proud of your country? Wear a T-shirt with a national symbol stamp!")}
        
        context "Graphql with wrong input for category" do
          let(:variables) do
            {
              input: {
                name: 'French', description: 'The French have always had an eye for b', id: 20
              }
            }
          end
          it 'returns an error' do
            post '/graphql', params: { query: query, variables: variables }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['errors'][0]

            expect(data).to include(
              "message"=> "Couldn't find Department with 'id'=20"
            )

          end
        end
      
        context 'Params with right input' do
          let(:variables) do
            {
              input: {
                name: 'French', description: 'The French have always had an eye for b', id: department.id
              }
            }
          end

          it 'returns a category' do
            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)

            data = json['data']["updateDepartment"]

            expect(data["description"]).to eq variables[:input][:description]
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation updateDepartment ($input: UpdateDepartmentInput!) {
            updateDepartment (input: $input) {
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