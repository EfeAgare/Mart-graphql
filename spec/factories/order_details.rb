FactoryBot.define do
  factory :order_detail do
    order
    attributes { "MyString" }
    product_name { "loveee" }
    unit_cost { "9.99" }
    product
  end
end
