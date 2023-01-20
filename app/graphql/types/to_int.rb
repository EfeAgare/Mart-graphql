class Types::ToInt < Types::BaseScalar
  description "coerce to Int"

  def self.coerce_input(input_value, context)
     input_value.to_i
  end
end