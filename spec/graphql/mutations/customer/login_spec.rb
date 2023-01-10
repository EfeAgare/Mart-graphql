require 'rails_helper'

module Mutations
  module Customer
    RSpec.describe Login, type: :request do
      describe '.resolve' do
    
        context "Graphql with email that doesn't exist" do
          let(:variables) do
            {
              input: {
                email: "love@gmail.com", password: "123456"
              }
            }
          end

          it 'returns an error' do
            customer = create(:customer, email: "eff@hh.com", password: "123456", name: "Efe")

            post '/graphql', params: { query: query, variables: variables }

            json = JSON.parse(response.body)
            data =  json['errors'][0]

            expect(data).to include(
              "message"=>"User not found or not registered yet"
            )
          end
        end
      

        context 'With email that already exist' do
          let(:variables) do
            {
              input: {
                email: "eff@hh.com", password: "123456"
              }
            }
          end
          it 'returns a customer' do
            customer = create(:customer, email: "eff@hh.com", password: "123456", name: "Efe")

            post '/graphql',  params: { query: query, variables: variables }
            
            json = JSON.parse(response.body)
            data = json['data']["login"]

            expect(data).to include(
              'email'          => customer.email,
              'name'           => customer.name,
            )
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation login ($input: LoginInput!) {
            login (input: $input) {
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
                token
            }
        }
        GRAPHQL
      end
    end
  end
end