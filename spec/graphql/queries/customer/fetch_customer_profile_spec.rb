require 'rails_helper'

module Queries
  module Customer
    RSpec.describe FetchCustomerProfile, type: :request do
      describe '.resolve' do
     
      let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        context "Graphql with input address" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query }, headers: set_token(customer)

            json = JSON.parse(response.body)
            binding.pry

            data =  json['data']['fetchCustomerProfile']

            expect(data["address1"]).to eq customer.address_1
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchCustomerProfile {
            fetchCustomerProfile {
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