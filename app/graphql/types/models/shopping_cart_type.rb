module Types
  class Models::ShoppingCartType < Types::BaseObject
    field :id, ID, null: false
    field :product_id, Types::ToInt, null: false
    field :attributes,  String, null: true
    field :quantity, Types::ToInt, null: false
    field :buy_now, Boolean, null: false
    field :card_id, String, null: false
  end
end