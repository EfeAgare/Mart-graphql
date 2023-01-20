require 'rails_helper'

module Queries
  module Product
    RSpec.describe FetchProductsInDepartment, type: :request do
      describe '.resolve' do
     
        let(:customer) { create(:customer, email: "eff@hh.com", password: "123456ty", name: "Efe")}

        let(:department) { create(:department, name: "Regional", description: "Proud of your country? Wear a T-shirt with a national symbol stamp!")}
      
        let(:category) { create(:category, name: 'French', description: 'The French have always had an eye for b', department: department)}
        let(:category_1) { create(:category, name: 'Love', description: 'The French have always had an eye for b', department: department)}

        let(:product) { create_list(:product, 4, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }
        let(:product_2) { create_list(:product, 4, name: 'Arc d''Triomphe', description: 'This beautiful and iconic T-shirt will no doubt lead you to your own triumph.', price: 14.99, discounted_price: 0.00, image: 'arc-d-triomphe.gif', image_2: 'arc-d-triomphe-2.gif', thumbnail: 'arc-d-triomphe-thumbnail.gif', display: 0) }
      
        let(:product_category_1) { build_list(:product_category, 4,  category: category) }
        let(:product_category_2) { build_list(:product_category, 4, category: category_1) }

        before do
          product_category_1.each_with_index do |category, index|
            category.product_id = product[index].id
            category.save
          end

          product_category_2.each_with_index do |category, index|
            category.product_id = product_2[index].id
            category.save
          end
        end

        context "Fetch products in Department" do
      
          it 'returns a successful output' do

            post '/graphql', params: { query: query, variables: {departmentId: department.id} }, headers: set_token(customer)

            json = JSON.parse(response.body)

            data =  json['data']['fetchProductsInDepartment']

            expect(data['products'].length).to eq ::Product.count
            expect(data['products'].first["name"]).to include product.first.name.as_json
          end
        end
      end

      def query
        <<~GRAPHQL
        query fetchProductsInDepartment($departmentId: ID!) {
            fetchProductsInDepartment(departmentId: $departmentId) {
              products {
                id
                name
                description
                price
                discountedPrice
                image
                image2
                thumbnail
              }
              totalPages
              count
            }
        }
        GRAPHQL
      end
    end
  end
end