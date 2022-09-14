class WelcomeController < ApplicationController
  def index
    render json: { success: "Welcome to EFE_MART API" }
  end
end
