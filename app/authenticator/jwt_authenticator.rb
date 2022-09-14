require "jwt"
require 'pry'

class JwtAuthenticator
  class << self
    include ErrorMessage

    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new body
    rescue
      unauthorized
    end

    def decode_header_token(request)
      if request.headers['Authorization'].present?
        begin
          jwt_payload = decode(request.headers['Authorization'].split(' ')[1])
          jwt_payload['user_id']
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          unauthorized
        end
      end
    end
  end
end
