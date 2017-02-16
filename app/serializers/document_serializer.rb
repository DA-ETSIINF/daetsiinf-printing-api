class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :folder_id, :name
  belongs_to :user
end
