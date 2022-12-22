# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_users)
    @user = current_user
    if @user.supervisor?
      approvals_path
    else
      edit_user_path(@user)
    end
  end

  def after_sign_out_path_for(_users)
    new_user_session_path
  end
end
