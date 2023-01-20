module Mutations
  class Product::CreateProduct < Mutations::BaseMutation
    argument :name, String, required: true
    argument :description, String, required: true
    argument :price, Types::ToFloat, required: true
    argument :discounted_price, Types::ToFloat,  required: true
    argument :image, String, required: false
    argument :image_2, String, required: false
    argument :thumbnail, String, required: false
    argument :display, Types::ToInt, required: false

    type Types::Models::Product::ProductType

    def resolve(**attributes)
      product = ::Product.new(attributes)

      if product.save
        product
      else
        unprocessable_entity(product.errors.full_messages)
      end
    end
  end
end
