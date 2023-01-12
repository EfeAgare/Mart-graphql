require 'rails_helper'

module Queries
  module Attribute
    RSpec.describe FetchAnAttribute, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:attribute) { build_list(:attribute, 3, name: "Regional")}

        let(:variables) do { id: attribute.first.id }  end

        before do
          attribute.map(&:save)
        end

        context "Fetch an attribute" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: variables }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchAnAttribute']

            expect(data["name"]).to eq ::Attribute.first.name
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchAnAttribute($id: ID!) {
            fetchAnAttribute(id: $id) {
              id
              name
            }
        }
        GRAPHQL
      end
    end
  end
end
