# frozen_string_literal: true
require 'jwt'
class VerificationMailer < ApplicationMailer
  
  def verify_email(user, token)
    @user = user
    @token = token
    mail to: @user.email, subject: 'Verify your email'
  end

  def notify_to_complete_profile(user,pass)
    @user = User.find(user.id)
    @pass = pass
    jwt_secret = "#{@user.id}our secret key"
    @token = JWT.encode(@user.email,jwt_secret)
    mail to: @user.email, subject: 'Complete your profile'
  end

end
