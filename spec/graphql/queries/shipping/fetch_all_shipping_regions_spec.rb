require 'rails_helper'

module Queries
  module Shipping
    RSpec.describe FetchAllShippingRegions, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:shipping_region) { create_list(:shipping_region, 3, region: "Nigeria") }

       
        before do
          shipping_region.map(&:save)
        end

        context "Fetch all shipping region" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchAllShippingRegions']

            expect(data.length).to eq 3
            expect(data.first["region"]).to include shipping_region.first.region.as_json
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchAllShippingRegions {
            fetchAllShippingRegions {
              id
              region
            }
        }
        GRAPHQL
      end
    end
  end
end