# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from.salman@rails.com'
  layout 'mailer'
end
