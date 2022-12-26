# frozen_string_literal: true

module ApprovalsHelper
  def get_status_class(status)
    case status
    when 'started'
      'bg-info bg-gradient'
    when 'pending'
      'bg-warning bg-gradient'
    when 'submitted'
      'bg-secondary bg-gradient'
    when 'approved'
      'bg-success bg-gradient'
    when 'rejected'
      'bg-danger bg-gradient'
    else
      'bg-dark bg-gradient'
    end
  end
end
