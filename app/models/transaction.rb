class Transaction < ApplicationRecord
  belongs_to :account

  validates :amount, presence: true
  validates :account_id, presence: true
  validates :tran_type, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0}
end
