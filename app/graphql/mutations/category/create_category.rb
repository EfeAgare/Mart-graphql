module Mutations
  class Category::CreateCategory < Mutations::BaseMutation
    argument :name, String, required: true
    argument :description, String, required: true
    argument :department_id, ID, required: true

    type Types::Models::CategoryType

    def resolve(**attributes)
      category = ::Category.new(attributes)

      if category.save
        category
      else
        unprocessable_entity(category.errors.full_messages)
      end
    end
  end
end
