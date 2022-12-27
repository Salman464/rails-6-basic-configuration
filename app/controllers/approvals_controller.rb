# frozen_string_literal: true

class ApprovalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Approval.select('users.first_name, users.last_name, users.contact, users.dob, users.email, users.cnic, users.address, users.gender, approvals.id as id, approvals.status, approvals.updated_at').joins(:user).ransack(params[:q])

    @approvals = @q.result(distinct: true).order(id: :desc).page(params[:page]).per(9)
    # render json: @approvals
  end

  def show
    @approval = Approval.select('users.first_name, users.last_name, users.contact, users.dob, users.email, users.cnic, users.address, users.gender, approvals.id as id, approvals.status, approvals.updated_at').joins(:user).find(params[:id])
  end

  def approve
    @approval = Approval.find(params[:id])
    redirect_to approval_path if @approval.update(status: 3)
  end

  def reject
    @approval = Approval.find(params[:id])
    redirect_to approval_path if @approval.update(status: 4)
  end

  def filter
    filterd = params[:approval]
    
    criteria = { status_eq: filterd[:status], user_gender_eq: filterd[:gender], user_dob_gteq: Date.today.years_ago(filterd[:to].to_i+1), user_dob_lteq: Date.today.years_ago(filterd[:from].to_i) }.reject { |_, v| v.blank? }
    @q = Approval.select('users.first_name, users.last_name, users.contact, users.dob, users.email, users.cnic, users.address, users.gender, approvals.id as id, approvals.status, approvals.updated_at').joins(:user).ransack(criteria)

    @approvals = @q.result(distinct: true).order(id: :desc).page(params[:page]).per(9)
    render 'index'
  end



end
