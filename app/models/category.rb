class Category < ApplicationRecord
  acts_as_paranoid without_default_scope: true
  has_many :books, dependent: :destroy

  validates :name, presence: true

  scope :sort_by_name, ->{order :name}
  scope :newest, ->{order created_at: :desc}
end
