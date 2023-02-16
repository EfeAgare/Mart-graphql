module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # Customer
    field :fetch_customer_profile, resolver: Queries::Customer::FetchCustomerProfile
   
    # Department
    field :fetch_all_departments, resolver: Queries::Department::FetchAllDepartments
    field :fetch_a_department, resolver: Queries::Department::FetchADepartment

    # Category
    field :fetch_a_category, resolver: Queries::Category::FetchACategory
    field :fetch_all_categories, resolver: Queries::Category::FetchAllCategories
    field :fetch_product_category, resolver: Queries::Category::FetchProductCategory
    field :fetch_all_categories_in_department, resolver: Queries::Category::FetchAllCategoriesInDepartment

    # Attribute
    field :fetch_all_attributes, resolver: Queries::Attribute::FetchAllAttributes
    field :fetch_an_attribute, resolver: Queries::Attribute::FetchAnAttribute
    field :fetch_product_attributes, resolver: Queries::Attribute::FetchProductAttributes
    field :fetch_all_attribute_values, resolver: Queries::Attribute::FetchAllAttributeValues

    # Product
    field :fetch_all_products, resolver: Queries::Product::FetchAllProducts
    field :fetch_product_reviews, resolver: Queries::Product::FetchProductReviews
    field :fetch_product, resolver: Queries::Product::FetchProduct
    field :fetch_products_in_category, resolver: Queries::Product::FetchProductsInCategory
    field :fetch_products_in_department, resolver: Queries::Product::FetchProductsInDepartment
    field :product_search, resolver: Queries::Product::ProductSearch

    ## Tax
    field :fetchTax, resolver: Queries::Tax::FetchTax
    field :fetchAllTax, resolver: Queries::Tax::FetchAllTax

    ## Shipping
    field :fetch_all_shipping_regions, resolver: Queries::Shipping::FetchAllShippingRegions
    field :fetch_shippings_in_regions, resolver: Queries::Shipping::FetchShippingsInRegion
  end
end
