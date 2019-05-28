class Suggest < ApplicationRecord
  include PublicActivity::Common
  belongs_to :user

  validates :title, presence: true
  scope :newest, ->{order created_at: :desc}
  enum status: [:waiting, :rejected, :accepted]

  delegate :name, to: :user, prefix: true, allow_nil: true

  scope :by_suggest, ->(user_id){where user_id: user_id if user_id.present?}
end
