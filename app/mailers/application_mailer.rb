# frozen_string_literal: true

# Parent class for any mail the system will generate.
#
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
