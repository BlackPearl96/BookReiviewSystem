class Like < ApplicationRecord
  include PublicActivity::Common
  # belongs_to :activity
  belongs_to :user
  belongs_to :book
  delegate :title, to: :book, prefix: :book, allow_nil: true
  scope :by_like_user, (lambda do |user_id, book_id|
    where user_id: user_id, book_id: book_id
  end)
end
