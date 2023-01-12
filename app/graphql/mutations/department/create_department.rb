module Mutations
  class Department::CreateDepartment < Mutations::BaseMutation
    argument :name, String, required: true
    argument :description, String, required: true

    type Types::Models::DepartmentType

    def resolve(**attributes)
      department = ::Department.new(attributes)

      if department.save
        department
      else
        unprocessable_entity(department.errors.full_messages)
      end
    end
  end
end
