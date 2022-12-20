class ApprovalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Approval.select('*').joins(:user).ransack(params[:q])

    @approvals = @q.result(distinct: true).select('approvals.id as id, users.first_name, users.last_name, users.email, users.gender, approvals.status, approvals.updated_at').joins(:user).page(params[:page]).per(9).order(id: :desc)
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
end
