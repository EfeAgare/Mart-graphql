# frozen_string_literal: true

module Queries
  class Category::FetchAllCategories < Queries::BaseQuery

    type [Types::Models::CategoryType], null: false
    
    def resolve(**params)
      category = ::Category.all
      
      category 
    end
  end
end
