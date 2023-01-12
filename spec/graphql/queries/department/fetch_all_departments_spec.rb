require 'rails_helper'

module Queries
  module Department
    RSpec.describe FetchAllDepartments, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:department) { build_list(:department, 3, name: "Regional", description: "Proud of your country? Wear a T-shirt with a national symbol stamp!")}
      
        before do
          department.map(&:save)
        end

        context "Fetch all departments" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchAllDepartments']

            expect(data.length).to eq 3
            expect(data[0]["name"]).to eq ::Department.first.name
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchAllDepartments {
            fetchAllDepartments {
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