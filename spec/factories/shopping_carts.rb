FactoryBot.define do
  factory :shopping_cart do
    product { nil }
    attributes { "MyString" }
    quantity { 1 }
    buy_now { false }
    added_on { "2022-09-14 23:18:53" }
  end
end
