module Mutations
  class Attribute::CreateAttributeValue < Mutations::BaseMutation
    argument :value, String, required: true
    argument :attribute_id, ID, required: true

    field :message, String, null: false

    def resolve(**attributes)
      attribute_value = ::AttributeValue.new(attributes)

      if attribute_value.save
        { message: "Attribute value created successfully" }
      else
        unprocessable_entity(attribute_value.errors.full_messages)
      end
    end
  end
end
