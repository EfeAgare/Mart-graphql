# frozen_string_literal: true

module Queries
  class Category::FetchACategory < Queries::BaseQuery

    argument :id, ID, required: true

    type Types::Models::CategoryType, null: false
    
    def resolve(**params)
      category = ::Category.find(params[:id])

      category
    rescue ActiveRecord::RecordNotFound => e
      not_found("#{e}")
    end
  end
end
