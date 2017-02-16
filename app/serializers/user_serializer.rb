class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :auth_token, :balance
  has_many :folders
  has_many :documents
end
