require 'rails_helper'

module Queries
  module Tax
    RSpec.describe FetchAllTax, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:tax) { build_list(:tax, 3, type: "Sales Tax at 8.5%", percentage: 8.5)}
      
        before do
          tax.map(&:save)
        end

        context "Fetch all taxes" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchAllTax']

            expect(data.length).to eq 3
            expect(data[0]["type"]).to eq ::Tax.first.type
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchAllTax {
            fetchAllTax {
              id
              type
              percentage
            }
        }
        GRAPHQL
      end
    end
  end
end