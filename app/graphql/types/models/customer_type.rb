# frozen_string_literal: true

module Types
  class Models::CustomerType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :mobile_phone_2, String, null: true
    field :mobile_phone, String, null: true
    field :country, String, null: true
    field :postal_code, String, null: true
    field :region, String, null: true
    field :city, String, null: true
    field :address_2, String, null: true
    field :address_1, String, null: true
    field :token, String, null: false
    field :credit_card, String, null: false
  end
end
