module Types
  class MutationType < Types::BaseObject

    # Customer
    field :register, mutation: Mutations::Customer::Register
    field :login, mutation: Mutations::Customer::Login
    field :update_customer_address, mutation: Mutations::Customer::UpdateCustomerAddress
    field :update_customer_credit_card, mutation: Mutations::Customer::UpdateCustomerCreditCard
    field :update_customer_details, mutation: Mutations::Customer::UpdateCustomerDetails

    # Department
    field :create_department, mutation: Mutations::Department::CreateDepartment

    # Category
    field :create_category, mutation: Mutations::Category::CreateCategory
    field :create_product_category, mutation: Mutations::Category::CreateProductCategory
    
    # Attribute
    field :create_attribute, mutation: Mutations::Attribute::CreateAttribute
    field :create_attribute_value, mutation: Mutations::Attribute::CreateAttributeValue

    # Product
    field :create_product_review, mutation: Mutations::Product::CreateProductReview
    field :create_product, mutation: Mutations::Product::CreateProduct
  end
end
