FactoryBot.define do
  factory :shipping do
    shipping_region
    cost { 1.5 }
    type { "" }
  end
end
