module Mutations
  class Product::CreateProductReview < Mutations::BaseMutation
    argument :product_id, ID, required: true
    argument :customer_id, ID, required: true
    argument :rating, Types::ToInt, required: true
    argument :review, String, required: true

    type Types::Models::Product::ReviewType

    def resolve(**attributes)
      review = ::Review.new(attributes)

      if review.save
        review
      else
        unprocessable_entity(review.errors.full_messages)
      end
    end
  end
end
