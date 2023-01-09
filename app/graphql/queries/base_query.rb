module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    include ErrorMessage

    def self.authorized?(object, context)
      unless context[:current_user] 
        raise GraphQL::ExecutionError.new("Unauthorized error", options: { status: :unauthorized, code: 401 })
      end

      super && context[:current_user]
    end
  end
end
