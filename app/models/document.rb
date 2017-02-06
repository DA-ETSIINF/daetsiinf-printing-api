class Document < ApplicationRecord
  validates :name, :folder_id, :url, presence: true
  validates :pages, numericality: { greater_than: 0 }, presence: true
  belongs_to :folder
end
