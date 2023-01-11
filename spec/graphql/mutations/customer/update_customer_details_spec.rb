require 'rails_helper'

module Mutations
  module Customer
    RSpec.describe UpdateCustomerDetails, type: :request do
      describe '.resolve' do
     
        let(:variables) do
            {
             input: {
              name: "EfeLove", mobilePhone: "+2348156787876"
            }
          }

        end
        
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        context "Graphql with real phone number" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: variables }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['updateCustomerDetails']

            expect(data["name"]).to eq variables[:input][:name]
          end
        end
      
        context 'Updating customer with fake number' do
         
          it 'returns an error' do

            variables[:input][:mobilePhone] = "123ertyhf"

            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)
            data =  json['errors'][0]

            expect(data).to include(
              "message"=> ["Mobile phone is invalid"]
            )
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation updateCustomerDetails ($input: UpdateCustomerDetailsInput!) {
            updateCustomerDetails (input: $input) {
                address1
                address2
                city
                country
                email
                mobilePhone
                name
                postalCode
                region
            }
        }
        GRAPHQL
      end
    end
  end
end