module Mutations
  class Tax::CreateTax < Mutations::BaseMutation
    argument :type, String, required: true
    argument :percentage, Types::ToFloat, required: true

    type Types::Models::TaxType, null: false

    def resolve(**params)
      tax = ::Tax.new(params)


      if tax.save
        tax
      else
        unprocessable_entity(tax.errors.full_messages)
      end
    end
  end
end
