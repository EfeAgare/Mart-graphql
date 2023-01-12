require 'rails_helper'

module Queries
  module Attribute
    RSpec.describe FetchAllAttributes, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:attribute) { build_list(:attribute, 3, name: "Regional")}
      
        before do
          attribute.map(&:save)
        end

        context "Fetch all attributes" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchAllAttributes']

            expect(data.length).to eq 3
            expect(data[0]["name"]).to eq ::Attribute.first.name
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchAllAttributes {
            fetchAllAttributes {
              id
              name
            }
        }
        GRAPHQL
      end
    end
  end
end