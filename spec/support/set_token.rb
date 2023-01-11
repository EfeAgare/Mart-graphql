def set_token(customer)
  token = ::GenerateToken.new.call(customer)

  headers = {"ACCEPT" => "application/json", "Authorization" => "Bearer #{token}" }
end