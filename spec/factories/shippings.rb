FactoryBot.define do
  factory :shipping do
    shipping_region { nil }
    cost { 1.5 }
    type { "" }
  end
end
