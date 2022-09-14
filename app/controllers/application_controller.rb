class ApplicationController < ActionController::API
  include UserAuthenticator
  include ErrorMessage
end
