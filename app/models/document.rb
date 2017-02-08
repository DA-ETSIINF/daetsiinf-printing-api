class Document < ApplicationRecord
  has_attached_file :file
  validates_attachment :file, presence: true, content_type: { content_type: "application/pdf" }
  validates :name, :folder_id, presence: true
  belongs_to :folder
  before_save
end
