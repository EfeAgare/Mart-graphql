require 'rails_helper'

module Mutations
  module Customer
    RSpec.describe UpdateCustomerCreditCard, type: :request do
       describe '.resolve' do

        let(:variables) do
            {
             input: {
              creditCard: "5274 5763 9425 9961"
            }
          }

          # '5274 5763 9425 9961'.credit_card_brand   #=> :mastercard
          # '5274 5763 9425 9961'.credit_card_brand_name   #=> "MasterCard"
        end
        
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        context "Graphql with real credit card" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: variables }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['updateCustomerCreditCard']

            expect(data["creditCard"]).to eq variables[:input][:creditCard]
          end
        end
      
        context 'Updating customer with fake credit card' do
         
          it 'returns an error' do

            variables[:input][:creditCard] = "123ertyhf"

            post '/graphql',  params: { query: query, variables: variables }, headers: set_token(customer)
            
            json = JSON.parse(response.body)
            data =  json['errors'][0]

            expect(data).to include(
              "message"=>"Invalid credit card"
            )
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation updateCustomerCreditCard ($input: UpdateCustomerCreditCardInput!) {
            updateCustomerCreditCard (input: $input) {
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
              creditCard
            }
        }
        GRAPHQL
      end
    end
  end
end