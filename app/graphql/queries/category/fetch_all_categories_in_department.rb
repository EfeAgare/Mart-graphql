# frozen_string_literal: true

module Queries
  class Category::FetchAllCategoriesInDepartment < Queries::BaseQuery

    argument :department_id, ID, required: true

    type [Types::Models::CategoryType], null: false
    
    def resolve(**params)
      categories_in_department = ::Category.where("department_id = ? ", params[:department_id])
      
      categories_in_department
    end
  end
end
