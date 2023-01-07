FactoryBot.define do
  factory :order_detail do
    order { nil }
    attributes { "MyString" }
    product_name { "" }
    unit_cost { "9.99" }
    product { nil }
  end
end
