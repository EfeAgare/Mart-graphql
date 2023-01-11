require 'rails_helper'

module Mutations
  module Customer
    RSpec.describe UpdateCustomerAddress, type: :request do
      describe '.resolve' do
     
        let(:shipping_region) { create(:shipping_region)}

        let(:variables) do
          {
            input: {
              address1: "1 trinity avenue",
              address2: "love",
              city: "Maryland",
              country: "Nigeria",
              postalCode: "12345",
              region: "West africa",
              shippingRegionId: shipping_region.id
           }
          }
        end

        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        context "Graphql with input address" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: variables }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['updateCustomerAddress']

            expect(data["address1"]).to eq variables[:input][:address1]
          end
        end
      
        context 'Updating customer address with a fake user' do
         
          it 'returns an error' do
            post '/graphql',  params: { query: query, variables: variables }, headers: {"Authorization" => "Bearer 56677888" }
            
            json = JSON.parse(response.body)
            data =  json['errors'][0]

            expect(data).to include(
              "message"=>"Unauthorized error"
            )
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation updateCustomerAddress ($input: UpdateCustomerAddressInput!) {
            updateCustomerAddress (input: $input) {
              address1
              address2
              city
              country
              email
              mobilePhone
              mobilePhone2
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