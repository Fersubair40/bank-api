class Account < ApplicationRecord


  belongs_to :user
  has_many :transactions


  validates :user_id, presence: true
  validates :balance, numericality: {greater_than_or_equal_to: 0}, presence: true
  validates :account_nr, presence: true
  before_validation :generate_account_nr, on: :create

  def generate_account_nr
    self.account_nr = account_nr_generator
  end


  def account_nr_generator
    first_enum = 30
    second_enum =  (SecureRandom.random_number(9e5) + 1e6).to_i
    identifier = first_enum.to_s + second_enum.to_s
    identifier.to_i
  end

  def self.deposit(account, amount)
    return false unless self.amount_valid?(amount)
    account.balance = (account.balance += amount).round(2)
    account.save!
  end
  def self.withdraw(account, amount)
    return false unless self.amount_valid?(amount)
    account.balance = (account.balance -= amount).round(2)
    account.save!
  end

  def self.transfer(account, recipient, amount)
    return false unless self.amount_valid?(amount)
    ActiveRecord::Base.transaction do
      self.withdraw(account, amount)
      self.deposit(recipient, amount)
    end
  end


  private
  def self.amount_valid?(amount)
    if amount <= 0
      puts 'Transaction failed! Amount must be greater than 0.00'
      return false
    end
    return true
  end
end
