module Mutations
  class Product::RemoveProduct < Mutations::BaseMutation
    argument :id, ID, required: true

    field :message, String, null: false
    
    def resolve(**params)
      product = ::Product.find(params[:id])

      if product.destroy
        {message: "Poduct deleted successfully"}
      else
        unprocessable_entity(product.errors.full_messages)
      end
    end
  end
end
