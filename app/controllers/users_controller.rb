# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_tokenclient, except: %i[edit update]
  before_action :set_approval_application, only: %i[edit update verification completed check_existing_application]
  before_action :check_existing_application, only: %i[edit verification completed]

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Updated user successfully.'
      @approval_application.update(status: 1) unless %w[pending completed accepted
                                                        rejected].include?(@approval_application.status)
      redirect_to verification_user_path
    else
      redirect_to edit_user_path, alert: @user.errors.full_messages.to_sentence
    end
  end

  def send_verification_token
    @token = @tokenclient.generate_token

    return unless VerificationMailer.verify_email(@user, @token).deliver_now

    @tokenclient.set_email_token(@user)
    flash[:success] = 'Verfication code sent successfully.'
    redirect_back(fallback_location: verification_user_path)
  end

  def verify_token
    if params[:entry_email_token] == @user.email_verification_token.to_s and @user.email_token_expires_at >= Time.now
      @user.update(email_verified: true)
      flash[:success] = 'Email verified successfully.'
    else
      flash.alert = 'Incorrect or expired verification code!.'
    end
    redirect_back(fallback_location: verification_user_path)
  end

  def send_number_verification_token
    @token = @tokenclient.generate_token
    return unless TwilioClient.new.send_text(@user,@token)
    #return unless true

    @tokenclient.set_contact_token(@user)
    flash[:success] = 'Verfication code sent successfully.'
    redirect_back(fallback_location: verification_user_path)
  end

  def verify_number_token
    if params[:entry_number_token] == @user.contact_verification_token.to_s and @user.contact_token_expires_at >= Time.now
      @user.update(number_verified: true)
      flash[:success] = 'Phone number verified successfully.'
    else
      flash.alert = 'Incorrect or expired verification code!.'
    end
    redirect_back(fallback_location: verification_user_path)
  end

  def verification
    byebug
    # verfication page
  end

  def completed
    # thankyou page
    @approval_application.update(status: 2) unless %w[completed accepted
                                                      rejected].include?(@approval_application.status)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :cnic, :contact, :dob, :address, :gender, :profile_picture,
                                 :cnic_picture, :dob_file, :domicile_file)
  end

  def set_user
    @user = current_user
  end

  def set_tokenclient
    @tokenclient = TokenClient.new
  end

  def set_approval_application
    @approval_application = Approval.where(user_id: current_user.id).first_or_initialize(status: 0)
    @approval_application.save
    @approval_application
  end

  def check_existing_application
    return unless %w[completed accepted rejected].include?(@approval_application.status)

    flash.alert = 'You have already responded.'
    render :completed
  end
end
