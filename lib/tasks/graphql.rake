# frozen_string_literal: true

namespace :graphql do
  task export: [:environment] do
    schema = EfeMartGraphqlSchema.execute(GraphQL::Introspection::INTROSPECTION_QUERY, variables: {}, context: {})

    File.write(Rails.root.join("graphql.json"), JSON.pretty_generate(schema))
  end
end
