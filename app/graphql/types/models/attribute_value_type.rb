module Types
  class Models::AttributeValueType < Types::BaseObject
    field :id, ID, null: false
    field :value, String, null: false
    field :attribute_id, ID, null: false
    field :attribute, Types::Models::AttributeType, null: false

    def attribute
      object.attri
    end
  end
end