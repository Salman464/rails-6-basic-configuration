class UsersController < ApplicationController
	before_action :set_user, only: %i[ edit update send_verification_token verification_token]

	def edit
		@user = User.find(params[:id])
	end

	def update
		respond_to do |format|
			if @user.update(user_params)

				format.html { redirect_to verification_user_path(@user), notice: "User was successfully updated." }
			else
				format.html { redirect_to edit_user_path, alert: @user.errors.full_messages.to_sentence }
			end
		end
	end

	def send_verification_token
        @token = rand(10000..99999)
        if VerificationMailer.verify_email(@user,@token).deliver_now
			@user.update(verification_token:@token)
            flash.alert = "Email sent successfully."
			redirect_back(fallback_location: edit_user_path)
        end
    end

	def verification_token
		if params[:entry_email_token] == @user.verification_token
			@user.update(email_verified:true)
			flash.alert = "Email verified successfully."
			redirect_back(fallback_location: edit_user_path)
		else
			flash.alert = "Incorrect verification code!."
			redirect_back(fallback_location: edit_user_path)
		end

	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name,:email,:cnic,:contact,:dob,:address,:gender,:profile_picture,:cnic_picture,:dob_file,:domicile_file)
	end

	def set_user
		@user=User.find(params[:id])
	end
end
