require 'rails_helper'

module Queries
  module Attribute
    RSpec.describe FetchAllAttributeValues, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:attribute) { create(:attribute, name: "Regional")}

        let(:attribute_values) { build_list(:attribute_value, 3, value: "Regional", attribute_id: attribute.id)}
      
       let(:variables) do { attributeId: attribute.id }  end

        before do
          attribute_values.map(&:save)
        end

        context "Fetch all attributeValues" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: variables }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchAllAttributeValues']

            expect(data.length).to eq 3
            expect(data[0]["value"]).to eq ::AttributeValue.first.value
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchAllAttributeValues($attributeId: ID!) {
            fetchAllAttributeValues(attributeId: $attributeId) {
              id
              value
            }
        }
        GRAPHQL
      end
    end
  end
end