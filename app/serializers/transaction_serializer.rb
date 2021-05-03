class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :tran_type, :account_id
end
