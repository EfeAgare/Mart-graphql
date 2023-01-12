module Mutations
  class Attribute::CreateAttribute < Mutations::BaseMutation
    argument :name, String, required: true

    field :message, String, null: false

    def resolve(**attributes)
      attribute = ::Attribute.new(attributes)

      if attribute.save
        {message: "Attribute created successfully"}
      else
        unprocessable_entity(attribute.errors.full_messages)
      end
    end
  end
end
