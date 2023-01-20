class Types::ToFloat < Types::BaseScalar
  description "coerce to Float"

  def self.coerce_input(input_value, context)
     input_value.to_f
  end
end