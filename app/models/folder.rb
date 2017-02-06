class Folder < ApplicationRecord
  validates :name, :user_id, presence: true
  has_many :documents, dependent: :destroy
  belongs_to :user
end
