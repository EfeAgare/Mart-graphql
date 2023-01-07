FactoryBot.define do
  factory :review do
    customer { "" }
    product { nil }
    review { "MyText" }
    rating { 1 }
    created_on { "2022-09-14 23:49:33" }
  end
end
