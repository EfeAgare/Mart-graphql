# frozen_string_literal: true

module Queries
  class Department::FetchAllDepartments < Queries::BaseQuery

    type [Types::Models::DepartmentType], null: false
    
    def resolve(**params)
      department = ::Department.all

      department
    end
  end
end
