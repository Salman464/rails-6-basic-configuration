class UsersController < ApplicationController
	def complete_profile
		@user = User.find(params[:id])

		render 'complete_profile'
	end

	def update
		if @user.update(user_params)
			notice:'personal information updated successfully'
		else
			render 'complete_profile', notice:'Invalid information in form!'
		end
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name,:email,:cnic,:contact,:dob,:address,:gender,:profile_picture,:cnic_picture,:dob_file,:domicile_file)
	end
end
