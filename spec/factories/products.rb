FactoryBot.define do
  factory :product do
    name { "MyString" }
    description { "MyString" }
    price { "9.99" }
    discounted_price { "9.99" }
    image { "MyString" }
    image_2 { "MyString" }
    thumbnail { "MyString" }
    display { 1 }
  end
end
