# Preview all emails at http://localhost:3000/rails/mailers/suggest_mailer
class SuggestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/suggest_mailer/suggest_confirmation
  def suggest_confirmation
    SuggestMailer.suggest_confirmation
  end

end
