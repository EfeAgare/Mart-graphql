module Types
  class Models::TotalAmountType < Types::BaseObject
    field :total_amount, Types::ToDecimal, null: false
  end
end