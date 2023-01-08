FactoryBot.define do
  factory :order do
    total_amount { "9.99" }
    created_on { "2022-09-14 23:44:12" }
    shipped_on { "2022-09-14 23:44:12" }
    status { 1 }
    comments { "MyString" }
    customer
    auth_code { "MyString" }
    reference { "MyString" }
    shipping 
    tax
  end
end
