# frozen_string_literal: true

module Types
  class Models::CategoryType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :department, Types::Models::DepartmentType, null: false

    def department
      object.department
    end
  end
end
