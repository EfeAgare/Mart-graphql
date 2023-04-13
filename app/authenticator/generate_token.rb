# frozen_string_literal: true

require "jwt"

class GenerateToken
  attr_accessor :user_id, :token

  def call(user)
    @user_id = user.id
    @token = generate_token
  end

  private

  def generate_token
    JWT.encode(payload, hmac_secret, hmac_algorithm)
  rescue StandardError => e
    Rails.logger.debug e.message
  end

  def payload
    {
      sub: @user_id,
      jti: jwt_id,
      iat: issued_at
    }
  end

  def jwt_id
    @jwt_id ||= Digest::MD5.hexdigest([hmac_secret, issued_at].join(":").to_s)
  end

  def hmac_secret
    ENV["HMAC_SECRET"]
  end

  def hmac_algorithm
    ENV["HMAC_ALGORITHM"]
  end

  def issued_at
    @issued_at ||= Time.current.to_i
  end
end
