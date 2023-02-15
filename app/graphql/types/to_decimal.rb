class Types::ToDecimal < Types::BaseScalar
  description "coerce to Decimal"

  def self.coerce_input(input_value, context)
     input_value.to_d
  end
end