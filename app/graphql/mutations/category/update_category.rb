module Mutations
  class Category::UpdateCategory < Mutations::BaseMutation
    argument :name, String, required: true
    argument :description, String, required: true
    argument :id, ID, required: true

    type Types::Models::CategoryType

    def resolve(**params)
      category = ::Category.find(params[:id])

      if category.present?
        category.update(params.except(:id))
        category
      else
        unprocessable_entity(category.errors.full_messages)
      end

      rescue ActiveRecord::RecordNotFound => e
        not_found(e)
    end
  end
end
