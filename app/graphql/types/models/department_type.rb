# frozen_string_literal: true

module Types
  class Models::DepartmentType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
  end
end
