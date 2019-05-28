class Mark < ApplicationRecord
  belongs_to :book
  belongs_to :user

  enum status: {favorite: 0, reading: 1, read: 2}
end
