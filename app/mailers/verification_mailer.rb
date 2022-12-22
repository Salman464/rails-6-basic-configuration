# frozen_string_literal: true

class VerificationMailer < ApplicationMailer
  def verify_email(user, token)
    @user = user
    @token = token
    mail to: @user.email, subject: 'Verify your email'
  end
end
