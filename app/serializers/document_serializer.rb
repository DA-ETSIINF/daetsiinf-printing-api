class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :folder_id, :name, :pages
end
