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
  end
end
