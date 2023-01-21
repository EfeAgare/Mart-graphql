# frozen_string_literal: true

module Types
  class Models::TaxType < Types::BaseObject
    field :id, ID, null: false
    field :type, String, null: false
    field :percentage, Float, null: false
  end
end
