class UsersController < ApplicationController
    def profile
        @user=User.find(params[:id])
        render 'complete_profile'
    end
end
