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
    field :update_department, mutation: Mutations::Department::UpdateDepartment

    # Category
    field :create_category, mutation: Mutations::Category::CreateCategory
    field :create_product_category, mutation: Mutations::Category::CreateProductCategory
    field :update_category, mutation: Mutations::Category::UpdateCategory
    
    # Attribute
    field :create_attribute, mutation: Mutations::Attribute::CreateAttribute
    field :create_attribute_value, mutation: Mutations::Attribute::CreateAttributeValue

    # Product
    field :create_product_review, mutation: Mutations::Product::CreateProductReview
    field :create_product, mutation: Mutations::Product::CreateProduct

    # Tax
    field :create_tax, mutation: Mutations::Tax::CreateTax

    # Order
    field :create_order, mutation: Mutations::Order::CreateOrder
    field :set_auth_code, mutation: Mutations::Order::SetAuthCode
    field :update_order, mutation: Mutations::Order::UpdateOrder
    field :update_shipping_date, mutation: Mutations::Order::UpdateShippingDate
    field :update_status, mutation: Mutations::Order::UpdateStatus

    # Shipping_cart
    field :addProduct, mutation: Mutations::ShoppingCart::AddProduct
    field :moveProductToCart, mutation: Mutations::ShoppingCart::MoveProductToCart
  end
end
