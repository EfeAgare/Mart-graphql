module Mutations
  class Department::UpdateDepartment < Mutations::BaseMutation
    argument :name, String, required: true
    argument :id, ID, required: true
    argument :description, String, required: true

    type Types::Models::DepartmentType

    def resolve(**params)
      department = ::Department.find(params[:id])

      if department.present?
        department.update(params.except(:id))
        department
      else
        unprocessable_entity(department.errors.full_messages)
      end

      rescue ActiveRecord::RecordNotFound => e
        not_found(e)
    end
  end
end
