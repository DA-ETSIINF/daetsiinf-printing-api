class Transaction < ApplicationRecord
  validates :user_id, :admin_id, :amount, presence: true
end
