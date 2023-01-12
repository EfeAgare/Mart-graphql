module Types
  class Models::ProductAttributeType < Types::BaseObject
    field :id, ID, null: false
    field :attribute_value, Types::Models::AttributeValueType, null: false

    def attribute_value 
      object.attribute_value
    end
  end
end