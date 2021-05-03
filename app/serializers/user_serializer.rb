class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :fullname
  has_one :account
end
