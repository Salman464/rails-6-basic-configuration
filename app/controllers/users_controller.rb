class UsersController < ApplicationController
	def edit
		@user = User.find(params[:id])
	end

	def update
		if @user.update(user_params)
			notice:'personal information updated successfully'
		else
			render 'complete_profile', notice:'Invalid information in form!'
		end
	end

	def send_verification_token
        @token = rand(10000..99999)
        if VerificationMailer::verify_email(user,token).deliver_now
            flash.alert = "Email send successfully."
        end
    end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name,:email,:cnic,:contact,:dob,:address,:gender,:profile_picture,:cnic_picture,:dob_file,:domicile_file)
	end

end
