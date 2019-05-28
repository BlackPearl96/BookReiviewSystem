require 'test_helper'

class SuggestMailerTest < ActionMailer::TestCase
  test "suggest_confirmation" do
    mail = SuggestMailer.suggest_confirmation
    assert_equal "Suggest confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
