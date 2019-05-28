class UserMailer < ApplicationMailer
  def suggest_confirm suggest
    @suggest = suggest
    mail to: suggest.user.email, subject: t("controller.mailers.user_mailer.suggest")
  end
end
