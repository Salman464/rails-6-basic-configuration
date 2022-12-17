class UsersController < ApplicationController
	before_action :set_user, only: %i[ edit update send_verification_token verify_token verification send_number_verification_token verify_number_token]

	def edit
		@user = User.find(params[:id])
	end

	def update
		if @user.update(user_params)
			flash.alert = "Updated user successfully."
			redirect_to verification_user_path

		else
			redirect_to edit_user_path, alert: @user.errors.full_messages.to_sentence 
		end
	end

	def send_verification_token
        @token = rand(10000..99999)
        if VerificationMailer.verify_email(@user,@token).deliver_now
			@user.update(verification_token:@token)
            flash.alert = "Verfication code sent successfully."
			redirect_back(fallback_location: verification_user_path)
        end
    end

	def verify_token
		if params[:entry_email_token].to_i == @user.verification_token
			@user.update(email_verified:true)
			flash.alert = "Email verified successfully."
			redirect_back(fallback_location: verification_user_path)
		else
			flash.alert = "Incorrect verification code!."
			redirect_back(fallback_location: verification_user_path)
		end
	end

	def send_number_verification_token
        @token = rand(10000..99999)
        #if TwilioClient.new.send_text(@user,@token)
        if true
			@user.update(verification_token:@token)
            flash.alert = "Verfication code sent successfully."
			redirect_back(fallback_location: verification_user_path)
        end
    end

	def verify_number_token
		if params[:entry_number_token].to_i == @user.verification_token
			@user.update(number_verified:true)
			flash.alert = "Phone number verified successfully."
			redirect_back(fallback_location: verification_user_path)
		else
			flash.alert = "Incorrect verification code!."
			redirect_back(fallback_location: verification_user_path)
		end
	end

	def verification
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name,:email,:cnic,:contact,:dob,:address,:gender,:profile_picture,:cnic_picture,:dob_file,:domicile_file)
	end

	def set_user
		@user=User.find(params[:id])
	end
end
