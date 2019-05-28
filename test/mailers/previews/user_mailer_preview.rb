class UserMailerPreview < ActionMailer::Preview
  # Preview this email at
  # http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end

  # http://localhost:3000/rails/mailers/user_mailer/suggest_confirm
  def suggest_confirm
    suggest = suggests.first
    UserMailer.suggest_confirm(suggest)
  end
end
