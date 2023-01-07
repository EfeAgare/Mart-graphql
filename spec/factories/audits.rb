FactoryBot.define do
  factory :audit do
    order { nil }
    created_on { "2022-09-14 23:47:43" }
    message { "MyText" }
    code { 1 }
  end
end
