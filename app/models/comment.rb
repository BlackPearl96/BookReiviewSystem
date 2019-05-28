class Comment < ApplicationRecord
  include PublicActivity::Common
  belongs_to :user
  belongs_to :review

  delegate :name, to: :user, prefix: :user, allow_nil: true
  delegate :title, to: :book, prefix: :book, allow_nil: true
  validates :content, presence: true,
   length: {maximum: Settings.comment.max_length}
end
