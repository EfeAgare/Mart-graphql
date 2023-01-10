require 'rails_helper'

module Mutations
  module Customer
    RSpec.describe Register, type: :request do
      describe '.resolve' do
     

        context "Graphql with wrong input" do
          let(:variables) do
            {
              input: {
                email: "eff@hh", password: "123456", name: "Efe"
              }
            }
          end
          it 'returns an error' do
            post '/graphql', params: { query: query, variables: variables }

            json = JSON.parse(response.body)
            data =  json['errors'][0]

            binding.pry
            expect(data).to include(
              "message"=>["Email is invalid"]
            )

          end
        end
      

        context 'Params with right input' do
          let(:variables) do
            {
              input: {
                email: "eff@hh.com", password: "123456", name: "Efe"
              }
            }
          end
          it 'returns a customer' do
            post '/graphql',  params: { query: query, variables: variables }
            
            json = JSON.parse(response.body)
            data = json['data']["register"]

            expect(data).to include(
              'email'          => variables[:input][:email],
              'name'           => variables[:input][:name],
            )
          end
        end
      end

      def query
        <<~GRAPHQL
        mutation register ($input: RegisterInput!) {
            register (input: $input) {
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