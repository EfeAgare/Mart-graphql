# frozen_string_literal: true

module Queries
  class Department::FetchADepartment < Queries::BaseQuery

    argument :id, ID, required: true

    type Types::Models::DepartmentType, null: false
    
    def resolve(**params)
      department = ::Department.find(params[:id])

      department
    rescue ActiveRecord::RecordNotFound => e
      not_found("#{e}")
    end
  end
end
