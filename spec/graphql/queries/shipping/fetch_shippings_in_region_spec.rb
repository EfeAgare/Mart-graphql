require 'rails_helper'

module Queries
  module Shipping
    RSpec.describe FetchShippingsInRegion, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:shipping_region) { create(:shipping_region, region: "Nigeria") }

        let(:shipping) { build_list(:shipping,3,  shipping_region_id: shipping_region.id, type: 'Next Day Delivery ($20)', cost: 20.00 ) }

        before do
          shipping.map(&:save)
        end

        context "Fetch all shippings in region" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: { shippingRegionId: shipping_region.id }  }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchShippingsInRegion']

            expect(data.length).to eq 3
            expect(data.first["cost"]).to eq shipping.first.cost.as_json
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchShippingsInRegion($shippingRegionId: ID!) {
          fetchShippingsInRegion(shippingRegionId: $shippingRegionId) {
            id
            cost
            type
          }
        }
        GRAPHQL
      end
    end
  end
end
