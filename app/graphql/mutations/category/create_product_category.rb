module Mutations
  class Category::CreateProductCategory < Mutations::BaseMutation
    argument :product_id, ID, required: true
    argument :department_id, ID, required: true

    field :message, String, null: false

    def resolve(**attributes)
      product_category = ::ProductCategory.new(attributes)

      if product_category.save
        {message: "Product category created successfully"}
      else
        unprocessable_entity(product_category.errors.full_messages)
      end
    end
  end
end
