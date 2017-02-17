class DashboardSerializer < ActiveModel::Serializer
  attributes :user, :shared_folders, :shared_documents

  def user
    UserSerializer.new(object)
  end

  def shared_folders
    User.find_by(id: 1).folders.map{ |f| FolderSerializer.new(f) }
  end

  def shared_documents
    User.find_by(id: 1).documents.map{ |d| DocumentSerializer.new(d) }
  end
end
