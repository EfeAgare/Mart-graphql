require 'rails_helper'

module Queries
  module Category
    RSpec.describe FetchAllCategories, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:department) { build(:department, name: "Regional", description: "Proud of your country? Wear a T-shirt with a national symbol stamp!")}
      
        let(:category) { build_list(:category, 3, name: 'French', description: 'The French have always had an eye for b', department: department)}

        before do
          department.save
          category.map(&:save)
        end

        context "Fetch all categories" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchAllCategories']

            expect(data.length).to eq 3
            expect(data[0]["name"]).to eq ::Category.first.name
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchAllCategories {
            fetchAllCategories {
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