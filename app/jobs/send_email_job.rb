class SendEmailJob < ApplicationJob
  queue_as :default

  def perform suggest
    @suggest = suggest
    UserMailer.suggest_confirm(@suggest).deliver_later
  end
end
