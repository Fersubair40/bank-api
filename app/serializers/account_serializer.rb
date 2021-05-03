class AccountSerializer < ActiveModel::Serializer
  attributes :id, :account_nr, :balance, :user_id

  belongs_to :user
  has_many :transactions
end
