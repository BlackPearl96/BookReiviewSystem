class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailer_sender
  layout "mailer"
end
