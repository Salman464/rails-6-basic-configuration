# frozen_string_literal: true

class TokenClient
  def initialize
    @token = nil
  end

  def generate_token
    @token = rand(10_000..99_999)
  end

  def set_email_token(user)
    user.update(email_verification_token: @token, email_token_expires_at: Time.now+3.minutes)
  end

  def set_contact_token(user)
    user.update(contact_verification_token: @token, contact_token_expires_at: Time.now+3.minutes)
  end
end
