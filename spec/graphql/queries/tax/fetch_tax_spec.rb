require 'rails_helper'

module Queries
  module Tax
    RSpec.describe FetchTax, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:tax) { build_list(:tax, 3, type: "Sales Tax at 8.5%", percentage: 8.5)}
      
        let(:variables) do { id: tax.first.id }  end

        before do
          tax.map(&:save)
        end

        context "Fetch a single tax" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: variables }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchTax']

            expect(data["type"]).to eq ::Tax.first.type
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchTax($id: ID!) {
            fetchTax(id: $id) {
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