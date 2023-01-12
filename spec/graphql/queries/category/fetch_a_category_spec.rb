require 'rails_helper'

module Queries
  module Category
    RSpec.describe FetchACategory, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:department) { build(:department, name: "Regional", description: "Proud of your country? Wear a T-shirt with a national symbol stamp!")}
      
        let(:category) { build(:category, name: 'French', description: 'The French have always had an eye for b', department: department)}

 
        let(:variables) do { id: category.id }  end

        before do
          department.save
          category.save         
        end

        context "Fetch a category" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: variables }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchACategory']

            expect(data["name"]).to eq ::Category.first.name
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchACategory($id: ID!) {
            fetchACategory(id: $id) {
              id
              description
              name
              department {
                id
                name
                description
              }
            }
        }
        GRAPHQL
      end
    end
  end
end
