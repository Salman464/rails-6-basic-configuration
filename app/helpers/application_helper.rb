# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice'
      'alert alert-info'
    when 'success'
      'alert alert-success'
    when 'error'
      'alert alert-danger'
    when 'alert'
      'alert alert-danger'
    end
  end

  def format_date(date)
    date.strftime('%d %b, %Y')
  end

  def get_age(dob)
    ((Date.today - dob) / 365).to_i
  end
end
