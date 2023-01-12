require 'rails_helper'

module Queries
  module Department
    RSpec.describe FetchADepartment, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:department) { build(:department, name: "Regional", description: "Proud of your country? Wear a T-shirt with a national symbol stamp!")}
      
        let(:variables) do { id: department.id }  end

        before do
          department.save        
        end

        context "Fetch a department" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: variables }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchADepartment']

            expect(data["name"]).to eq ::Department.first.name
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchADepartment($id: ID!) {
            fetchADepartment(id: $id) {
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