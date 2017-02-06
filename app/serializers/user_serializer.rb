class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :auth_token, :balance
end
