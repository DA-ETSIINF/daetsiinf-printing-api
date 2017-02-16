class Document < ApplicationRecord
  has_attached_file :file
  before_validation :count_pages
  validates_attachment :file, presence: true, content_type: { content_type: "application/pdf" }
  validates :name, :folder_id, :user_id, presence: true
  validates :pages, numericality: { greater_than: 0 }, presence: true
  before_save :add_extension_change_name
  belongs_to :user
  belongs_to :folder

  private

    def count_pages
      f = open(self.file.queued_for_write[:original].path)
      self.pages = PDF::Reader.new(f).page_count
    end

    def add_extension_change_name
      tempfile = self.file.queued_for_write[:original]
      unless tempfile.nil?
        extension = File.extname(tempfile.original_filename)
        name = self.name.downcase.split(" ").join("-")
        if !extension || extension == ''
          mime = tempfile.content_type
          ext = Rack::Mime::MIME_TYPES.invert[mime]
          self.file.instance_write :file_name, "#{name}#{ext}"
        end
      end
    end
end
