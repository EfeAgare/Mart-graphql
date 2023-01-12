require 'rails_helper'

module Queries
  module Category
    RSpec.describe FetchAllCategoriesInDepartment, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:department) { build(:department, name: "Regional", description: "Proud of your country? Wear a T-shirt with a national symbol stamp!")}
      
        let(:category) { build(:category, name: 'French', description: 'The French have always had an eye for b', department: department)}

        let(:variables) do { departmentId: department.id }  end

        before do
          category.save         
        end

        context "Fetch all categories in department" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: variables }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchAllCategoriesInDepartment']

            expect(data[0]["name"]).to eq ::Category.first.name
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchAllCategoriesInDepartment($departmentId: ID!) {
            fetchAllCategoriesInDepartment(departmentId: $departmentId) {
              id
              description
              name
            }
        }
        GRAPHQL
      end
    end
  end
end