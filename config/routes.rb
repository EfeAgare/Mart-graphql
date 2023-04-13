Rails.application.routes.draw do
  devise_for :customers
  root "welcome#index"

  # devise_for :users

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end

  post "/graphql", to: "graphql#execute"
  post "/stripe/webhook", to: "webhook#stripe"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
